from fastapi import APIRouter, HTTPException

from ..models.team import TeamStats
from ..services.team_service import get_team_activities

router = APIRouter(prefix="/teams", tags=["teams"])


@router.get("/{team_id}/activities", response_model=TeamStats)
def fetch_team_activities(team_id: str) -> TeamStats:
    stats = get_team_activities(team_id)

    if stats is None:
        raise HTTPException(status_code=404, detail=f"Team '{team_id}' not found")

    return stats
