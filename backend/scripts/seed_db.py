import asyncio
from datetime import UTC, datetime

from motor.motor_asyncio import AsyncIOMotorClient
from src.config import settings
from src.data.seed import TEAMS_DATA, USERS_DATA


async def seed() -> None:
    client = AsyncIOMotorClient(settings.MONGODB_URL)
    db = client[settings.MONGODB_DB]

    await db.activities.delete_many({})
    await db.teams.delete_many({})

    activity_docs = []
    for user_id, activities in USERS_DATA.items():
        for a in activities:
            activity_docs.append(
                {
                    "user_id": user_id,
                    "type": a.type,
                    "date": datetime(
                        a.date.year,
                        a.date.month,
                        a.date.day,
                        tzinfo=UTC,
                    ),
                    "duration": a.duration,
                    "distance": a.distance,
                    "elevation": a.elevation,
                }
            )
    result = await db.activities.insert_many(activity_docs)
    print(f"Inserted {len(result.inserted_ids)} activities")

    team_docs = []
    for team_id, members in TEAMS_DATA.items():
        team_docs.append({"team_id": team_id, "members": members})
    result = await db.teams.insert_many(team_docs)
    print(f"Inserted {len(result.inserted_ids)} teams")

    client.close()
    print("Database seeded successfully!")


if __name__ == "__main__":
    asyncio.run(seed())
