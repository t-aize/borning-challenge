from pydantic import BaseModel

from .activity import ActivityStats


class TeamStats(BaseModel):
    team_id: str
    members: list[str]
    stats: ActivityStats
