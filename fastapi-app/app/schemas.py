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
    # mem_no: int
    pass

class CarMemberResponse(CarMemberBase):
    mem_no: int

    class Config:
        orm_mode = True

class CarStoreResponse(BaseModel):
    store_cd: int
    store_addr: str
    class Config: orm_mode = True

class CarProductResponse(BaseModel):
    prod_cd: int
    brand: str | None = None
    type: str | None = None
    class Config: orm_mode = True

class CarOrderResponse(BaseModel):
    order_no: int
    mem_no: int
    order_date: date
    store_cd: int
    class Config: orm_mode = True

class CarOrderDetailResponse(BaseModel):
    order_no: int
    prod_cd: int
    quantity: int
    class Config: orm_mode = True