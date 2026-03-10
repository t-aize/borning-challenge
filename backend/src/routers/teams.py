from fastapi import APIRouter, HTTPException

from ..models.team import TeamStats
from ..services.team_service import get_team_activities, get_team_ids

router = APIRouter(prefix="/teams", tags=["teams"])


@router.get("", response_model=list[str])
async def fetch_team_ids() -> list[str]:
    return await get_team_ids()


@router.get("/{team_id}/activities", response_model=TeamStats)
async def fetch_team_activities(team_id: str) -> TeamStats:
    stats = await get_team_activities(team_id)

    if stats is None:
        raise HTTPException(status_code=404, detail=f"Team '{team_id}' not found")

    return stats
