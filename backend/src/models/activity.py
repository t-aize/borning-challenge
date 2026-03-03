from datetime import date

from pydantic import BaseModel


class Activity(BaseModel):
    id: str
    type: str  # "cycling", "running", etc.
    date: date
    duration: int  # minutes
    distance: float  # kilometers
    elevation: float  # meters


class ActivityStats(BaseModel):
    total_km: float
    total_elevation: float
    total_duration: int
    activity_count: int
    activities: list[Activity]
