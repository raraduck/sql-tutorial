from pydantic import BaseModel
from datetime import date

class UserCreate(BaseModel):
    name: str
    email: str

class UserResponse(UserCreate):
    id: int

    class Config:
        orm_mode = True

class CarMemberBase(BaseModel):
    gender: str | None = None
    age: int | None = None
    addr: str | None = None
    join_date: date | None = None

class CarMemberCreate(CarMemberBase):
    mem_no: int

class CarMemberResponse(CarMemberBase):
    mem_no: int

    class Config:
        orm_mode = True