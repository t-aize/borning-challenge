from ..config import settings
from ..data.seed import USERS_DATA
from ..database import get_db
from ..models.activity import Activity, ActivityStats


async def get_user_activities(user_id: str) -> ActivityStats | None:
    if settings.is_production:
        return await _get_from_db(user_id)
    return _get_from_seed(user_id)


def _get_from_seed(user_id: str) -> ActivityStats | None:
    activities = USERS_DATA.get(user_id)
    if activities is None:
        return None
    return _compute_stats(activities)


async def _get_from_db(user_id: str) -> ActivityStats | None:
    db = get_db()
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
    return _compute_stats(activities)


def _compute_stats(activities: list[Activity]) -> ActivityStats:
    return ActivityStats(
        total_km=round(sum(a.distance for a in activities), 2),
        total_elevation=round(sum(a.elevation for a in activities), 2),
        total_duration=sum(a.duration for a in activities),
        activity_count=len(activities),
        activities=sorted(activities, key=lambda a: a.date, reverse=True),
    )
