import aws_lambda_powertools
import fastapi
import mangum

from routes import blog, auth

logger = aws_lambda_powertools.Logger()

app = fastapi.FastAPI()

app.include_router(auth.router)
app.include_router(blog.router)


handler = mangum.Mangum(app)
