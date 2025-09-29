from fastapi import FastAPI
from app.routers import users
from app.routers import mart
from app.database import engine, Base

app = FastAPI()

# Base.metadata.create_all(bind=engine)

app.include_router(users.router)

app.include_router(mart.router, prefix="/mart", tags=["mart"])
# app.include_router(mart.router, prefix="/mart", tags=["mart"])
# app.include_router(mart.router, prefix="/mart", tags=["mart"])
# app.include_router(mart.router, prefix="/mart", tags=["mart"])
# app.include_router(mart.router, prefix="/mart", tags=["mart"])

@app.get("/")
def read_root():
    return {"message": "Welcome to FastAPI with PostgresSQL!"}