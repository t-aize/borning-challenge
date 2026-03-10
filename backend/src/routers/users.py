from fastapi import APIRouter, HTTPException

from ..models.activity import ActivityStats
from ..services.user_service import get_user_activities, get_user_ids

router = APIRouter(prefix="/users", tags=["users"])


@router.get("", response_model=list[str])
async def fetch_user_ids() -> list[str]:
    return await get_user_ids()


@router.get("/{user_id}/activities", response_model=ActivityStats)
async def fetch_user_activities(user_id: str) -> ActivityStats:
    stats = await get_user_activities(user_id)

    if stats is None:
        raise HTTPException(status_code=404, detail=f"User '{user_id}' not found")

    return stats
