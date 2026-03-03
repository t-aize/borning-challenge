import pytest
from httpx import ASGITransport, AsyncClient

from src.main import app


@pytest.fixture
async def client():
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac


async def test_get_team_activities_success(client: AsyncClient):
    response = await client.get("/teams/team_1/activities")

    assert response.status_code == 200
    data = response.json()
    assert data["team_id"] == "team_1"
    assert len(data["members"]) == 6
    assert data["stats"]["activity_count"] == 17
    assert data["stats"]["total_km"] > 0
    assert data["stats"]["total_elevation"] > 0
    assert data["stats"]["total_duration"] > 0


async def test_get_team_activities_not_found(client: AsyncClient):
    response = await client.get("/teams/unknown_team/activities")

    assert response.status_code == 404
    assert "not found" in response.json()["detail"].lower()


async def test_team_stats_are_sum_of_members(client: AsyncClient):
    """Team stats should equal the sum of all member stats."""
    team_resp = await client.get("/teams/team_1/activities")
    team_data = team_resp.json()

    total_km = 0.0
    total_elevation = 0.0
    total_duration = 0
    total_count = 0

    for member in team_data["members"]:
        user_resp = await client.get(f"/users/{member}/activities")
        user_data = user_resp.json()
        total_km += user_data["total_km"]
        total_elevation += user_data["total_elevation"]
        total_duration += user_data["total_duration"]
        total_count += user_data["activity_count"]

    assert team_data["stats"]["total_km"] == pytest.approx(total_km)
    assert team_data["stats"]["total_elevation"] == pytest.approx(total_elevation)
    assert team_data["stats"]["total_duration"] == total_duration
    assert team_data["stats"]["activity_count"] == total_count


async def test_team_activities_sorted_by_date_desc(client: AsyncClient):
    response = await client.get("/teams/team_1/activities")

    data = response.json()
    dates = [a["date"] for a in data["stats"]["activities"]]
    assert dates == sorted(dates, reverse=True)


async def test_team_members_count(client: AsyncClient):
    """Each team must have exactly 6 members."""
    response = await client.get("/teams/team_1/activities")

    data = response.json()
    assert len(data["members"]) == 6
