from fastapi import FastAPI
from app.routers import users, members
from app.database import engine, Base

app = FastAPI()

# Base.metadata.create_all(bind=engine)

app.include_router(users.router)
app.include_router(members.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to FastAPI with PostgresSQL!"}