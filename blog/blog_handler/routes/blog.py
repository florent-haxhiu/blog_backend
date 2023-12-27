# BLOG ROUTES

from fastapi import APIRouter


router = APIRouter(prefix="/blogs", tags=["blogs"])


@router.get("/")
async def get_all_blogs():
    return "All Blogs"


@router.get("/{blog_id}")
async def get_blog(blog_id: str):
    return f"{blog_id} Blog"
