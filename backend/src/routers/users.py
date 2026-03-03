from fastapi import APIRouter, HTTPException

from ..models.activity import ActivityStats
from ..services.user_service import get_user_activities

router = APIRouter(prefix="/users", tags=["users"])


@router.get("/{user_id}/activities", response_model=ActivityStats)
def fetch_user_activities(user_id: str) -> ActivityStats:
    stats = get_user_activities(user_id)

    if stats is None:
        raise HTTPException(status_code=404, detail=f"User '{user_id}' not found")

    return stats
