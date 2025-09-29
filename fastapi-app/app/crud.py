from sqlalchemy.orm import Session
from app import models, schemas

def create_user(db:Session, user: schemas.UserCreate):
    db_user = models.User(name=user.name, email=user.email)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def get_users(db: Session, skip: int=0, limit: int=10):
    # return db.query(models.User).offset(skip).limit(limit).all()
    return db.query(models.User).all()

def get_members(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.CarMember).offset(skip).limit(limit).all()

def create_member(db: Session, member: schemas.CarMemberCreate):
    db_member = models.CarMember(**member.dict())
    db.add(db_member)
    db.commit()
    db.refresh(db_member)
    return db_member