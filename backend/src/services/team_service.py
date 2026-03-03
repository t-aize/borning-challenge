from ..data.seed import TEAMS_DATA, USERS_DATA
from ..models.activity import Activity, ActivityStats
from ..models.team import TeamStats


def get_team_activities(team_id: str) -> TeamStats | None:
    member_ids = TEAMS_DATA.get(team_id)

    if member_ids is None:
        return None

    all_activities: list[Activity] = []
    for uid in member_ids:
        activities = USERS_DATA.get(uid, [])
        all_activities.extend(activities)

    return TeamStats(
        team_id=team_id,
        members=member_ids,
        stats=_compute_stats(all_activities),
    )


def _compute_stats(activities: list[Activity]) -> ActivityStats:
    return ActivityStats(
        total_km=round(sum(a.distance for a in activities), 2),
        total_elevation=round(sum(a.elevation for a in activities), 2),
        total_duration=sum(a.duration for a in activities),
        activity_count=len(activities),
        activities=sorted(activities, key=lambda a: a.date, reverse=True),
    )
