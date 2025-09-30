from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import crud, schemas, database

router = APIRouter(prefix="/members", tags=["members"])

@router.get("/", response_model=[schemas.CarMemberResponse])
def read_members(skip: int = 0, limit: int = 10, db: Session = Depends(database.get_db)):
    return crud.get_members(db, skip=skip, limit=limit)

@router.post("/", response_model=schemas.CarMemberResponse)
def create_member(member: schemas.CarMemberCreate, db: Session = Depends(database.get_db)):
    return crud.create_member(db, member)