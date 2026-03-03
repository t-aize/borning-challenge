from ..config import settings
from ..data.seed import TEAMS_DATA, USERS_DATA
from ..database import get_db
from ..models.activity import Activity, ActivityStats
from ..models.team import TeamStats


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
        stats=_compute_stats(all_activities),
    )


async def _get_from_db(team_id: str) -> TeamStats | None:
    db = get_db()
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
        stats=_compute_stats(activities),
    )


def _compute_stats(activities: list[Activity]) -> ActivityStats:
    return ActivityStats(
        total_km=round(sum(a.distance for a in activities), 2),
        total_elevation=round(sum(a.elevation for a in activities), 2),
        total_duration=sum(a.duration for a in activities),
        activity_count=len(activities),
        activities=sorted(activities, key=lambda a: a.date, reverse=True),
    )
