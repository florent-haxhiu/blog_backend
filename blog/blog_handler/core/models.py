from typing import TypedDict


class BlogModel(TypedDict):
    id: int
    title: str
    blogBody: str
    timestamp: int


class GetBlogModel(TypedDict):
    id: int
