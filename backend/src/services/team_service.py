from ..config import settings
from ..data.seed import TEAMS_DATA, USERS_DATA
from ..database import database
from ..models.activity import Activity
from ..models.team import TeamStats
from .stats import compute_stats


async def get_team_ids() -> list[str]:
    if settings.is_production:
        db = database.get()
        docs = await db.teams.find({}, {"team_id": 1}).to_list(None)
        return [doc["team_id"] for doc in docs]
    return list(TEAMS_DATA.keys())


async def get_team_activities(team_id: str) -> TeamStats | None:
    if settings.is_production:
        return await _get_from_db(team_id)
    return _get_from_seed(team_id)


def _get_from_seed(team_id: str) -> TeamStats | None:
    member_ids = TEAMS_DATA.get(team_id)
    if member_ids is None:
        return None
    all_activities: list[Activity] = []
    for uid in member_ids:
        all_activities.extend(USERS_DATA.get(uid, []))
    return TeamStats(
        team_id=team_id,
        members=member_ids,
        stats=compute_stats(all_activities),
    )


async def _get_from_db(team_id: str) -> TeamStats | None:
    db = database.get()
    team_doc = await db.teams.find_one({"team_id": team_id})
    if team_doc is None:
        return None
    member_ids: list[str] = team_doc["members"]
    docs = await db.activities.find({"user_id": {"$in": member_ids}}).to_list(None)
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
    return TeamStats(
        team_id=team_id,
        members=member_ids,
        stats=compute_stats(activities),
    )
