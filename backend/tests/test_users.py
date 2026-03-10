import pytest
from httpx import ASGITransport, AsyncClient

from src.main import app


@pytest.fixture
async def client():
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac


async def test_get_user_activities_success(client: AsyncClient):
    response = await client.get("/users/user_1/activities")

    assert response.status_code == 200
    data = response.json()
    assert data["activity_count"] == 3
    assert data["total_km"] == 45.5
    assert data["total_elevation"] == 570.0
    assert data["total_duration"] == 195
    assert len(data["activities"]) == 3


async def test_get_user_activities_not_found(client: AsyncClient):
    response = await client.get("/users/unknown_user/activities")

    assert response.status_code == 404
    assert "not found" in response.json()["detail"].lower()


async def test_user_activities_sorted_by_date_desc(client: AsyncClient):
    response = await client.get("/users/user_1/activities")

    data = response.json()
    dates = [a["date"] for a in data["activities"]]
    assert dates == sorted(dates, reverse=True)


async def test_all_seed_users_exist(client: AsyncClient):
    for i in range(1, 7):
        response = await client.get(f"/users/user_{i}/activities")
        assert response.status_code == 200
        assert response.json()["activity_count"] > 0


async def test_activity_fields(client: AsyncClient):
    response = await client.get("/users/user_1/activities")

    activity = response.json()["activities"][0]
    assert "id" in activity
    assert "type" in activity
    assert "date" in activity
    assert "duration" in activity
    assert "distance" in activity
    assert "elevation" in activity


async def test_get_user_ids(client: AsyncClient):
    response = await client.get("/users")

    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert len(data) == 6
    assert "user_1" in data


async def test_get_user_ids_contains_all_seed_users(client: AsyncClient):
    response = await client.get("/users")

    data = response.json()
    for i in range(1, 7):
        assert f"user_{i}" in data
