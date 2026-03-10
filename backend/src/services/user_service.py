from ..config import settings
from ..data.seed import USERS_DATA
from ..database import database
from ..models.activity import Activity, ActivityStats
from .stats import compute_stats


async def get_user_ids() -> list[str]:
    if settings.is_production:
        db = database.get()
        return await db.activities.distinct("user_id")
    return list(USERS_DATA.keys())


async def get_user_activities(user_id: str) -> ActivityStats | None:
    if settings.is_production:
        return await _get_from_db(user_id)
    return _get_from_seed(user_id)


def _get_from_seed(user_id: str) -> ActivityStats | None:
    activities = USERS_DATA.get(user_id)
    if activities is None:
        return None
    return compute_stats(activities)


async def _get_from_db(user_id: str) -> ActivityStats | None:
    db = database.get()
    docs = await db.activities.find({"user_id": user_id}).to_list(None)
    if not docs:
        return None
    activities = [
        Activity(
            id=str(doc["_id"]),
            type=doc["type"],
            date=doc["date"],
            duration=doc["duration"],
            distance=doc["distance"],
            elevation=doc["elevation"],
        )
        for doc in docs
    ]
    return compute_stats(activities)
