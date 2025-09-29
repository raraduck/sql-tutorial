from sqlalchemy import Column, Integer, String, Date, ForeignKey, BigInteger
from sqlalchemy.orm import relationship
from app.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, unique=True, index=True)

class CarMember(Base):
    __tablename__ = "car_member"
    __table_args__ = {"schema": "mart"}

    mem_no = Column(Integer, primary_key=True, index=True)
    gender = Column(String(50))
    age = Column(Integer)
    addr = Column(String(50))
    join_date = Column(Date)

    orders = relationship("CarOrder", back_populates="member")

class CarStore(Base):
    __tablename__ = "car_store"
    __table_args__ = {"schema": "mart"}

    store_cd = Column(Integer, primary_key=True, index=True)
    store_addr = Column(String(50))

    orders = relationship("CarOrder", back_populates="store")

class CarOrder(Base):
    __tablename__ = "car_order"
    __table_args__ = {"schema": "mart"}

    order_no = Column(Integer, primary_key=True, index=True)
    mem_no = Column(Integer, ForeignKey("mart.car_member.mem_no"))
    order_date = Column(Date)
    store_cd = Column(Integer, ForeignKey("mart.car_store.store_cd"))

    member = relationship("CarMember", back_populates="orders")
    store = relationship("CarStore", back_populates="orders")
    details = relationship("CarOrderDetail", back_populates="order")

class CarProduct(Base):
    __tablename__ = "car_product"
    __table_args__ = {"schema": "mart"}

    prod_cd = Column(Integer, primary_key=True, index=True)
    brand = Column(String(50))
    type = Column(String(50))  # reserved word라면 "" 대신 컬럼명 그대로 사용 가능
    model = Column(String(50))
    price = Column(BigInteger)

    details = relationship("CarOrderDetail", back_populates="product")

class CarOrderDetail(Base):
    __tablename__ = "car_orderdetail"
    __table_args__ = {"schema": "mart"}

    order_no = Column(Integer, ForeignKey("mart.car_order.order_no"), primary_key=True)
    prod_cd = Column(Integer, ForeignKey("mart.car_product.prod_cd"), primary_key=True)
    quantity = Column(Integer)

    order = relationship("CarOrder", back_populates="details")
    product = relationship("CarProduct", back_populates="details")