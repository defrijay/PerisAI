from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database.database import get_db
from schemas import schemas
from services import user_service

router = APIRouter(prefix="/users", tags=["Users"])

# Get All User
@router.get("/", response_model=list[schemas.User])
def read_users(db: Session = Depends(get_db)):
    return user_service.get_users(db)

# Get All User By Id
@router.get("/{user_id}", response_model=schemas.User)
def read_user(user_id: int, db: Session = Depends(get_db)):
    return user_service.get_user(db, user_id)

# Send User Data
@router.post("/", response_model=schemas.User)
def create_user(identity: schemas.UserCreate, db: Session = Depends(get_db)):
    return user_service.create_user(db, identity)

# Replace / Change User Data By Id
@router.put("/{user_id}", response_model=schemas.User)
def update_user(user_id: int, identity: schemas.UserCreate, db: Session = Depends(get_db)):
    return user_service.update_user(db, user_id, identity)

# Update User Data By Id
@router.patch("/{user_id}", response_model=schemas.User)
def patch_user(user_id: int, identity: dict, db: Session = Depends(get_db)):
    return user_service.patch_user(db, user_id, identity)

# Delete User Data By Id
@router.delete("/{user_id}")
def delete_user(user_id: int, db: Session = Depends(get_db)):
    return user_service.delete_user(db, user_id)