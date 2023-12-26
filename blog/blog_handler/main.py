import aws_lambda_powertools
import fastapi
import mangum

logger = aws_lambda_powertools.Logger()

app = fastapi.FastAPI()


@app.get('/')
async def return_hello_world():
    return {'message': 'Hello World'}


handler = mangum.Mangum(app)
