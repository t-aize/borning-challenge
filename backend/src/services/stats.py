from ..models.activity import Activity, ActivityStats


def compute_stats(activities: list[Activity]) -> ActivityStats:
    return ActivityStats(
        total_km=round(sum(a.distance for a in activities), 2),
        total_elevation=round(sum(a.elevation for a in activities), 2),
        total_duration=sum(a.duration for a in activities),
        activity_count=len(activities),
        activities=sorted(activities, key=lambda a: a.date, reverse=True),
    )
