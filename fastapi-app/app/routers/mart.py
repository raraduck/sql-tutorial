from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
import app.crud as crud
import app.schemas as schemas

router = APIRouter()

@router.get("/members", response_model=list[schemas.CarMemberResponse])
def read_members(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return crud.get_members(db, skip=skip, limit=limit)

@router.post("/members", response_model=schemas.CarMemberResponse)
def create_member(member: schemas.CarMemberCreate, db: Session = Depends(get_db)):
    return crud.create_member(db, member)

@router.get("/stores", response_model=list[schemas.CarStoreResponse])
def read_stores(db: Session = Depends(get_db)):
    return crud.get_stores(db)

@router.get("/products", response_model=list[schemas.CarProductResponse])
def read_products(db: Session = Depends(get_db)):
    return crud.get_products(db)

@router.get("/orders", response_model=list[schemas.CarOrderResponse])
def read_orders(db: Session = Depends(get_db)):
    return crud.get_orders(db)

@router.get("/orderdetails", response_model=list[schemas.CarOrderDetailResponse])
def read_orderdetails(db: Session = Depends(get_db)):
    return crud.get_orderdetails(db)
