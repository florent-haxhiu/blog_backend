# AUTH ROUTES

from typing import Dict
from fastapi import APIRouter


router = APIRouter(prefix="/auth", tags=["auth"])


@router.post('/register')
async def register(request_body: Dict):
    return 'Not signed up'


@router.post('/login')
async def login(request_body: Dict):
    return 'Not Logged In'
