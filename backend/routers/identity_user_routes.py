from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database.database import get_db
from schemas import schemas
from services import identity_user_service

router = APIRouter(prefix="/identity_users", tags=["Identity Users"])


@router.get("/", response_model=list[schemas.IdentityUser])
def read_identity_users(db: Session = Depends(get_db)):
    return identity_user_service.get_identity_users(db)


@router.get("/{identity_id}", response_model=schemas.IdentityUser)
def read_identity_user(identity_id: int, db: Session = Depends(get_db)):
    return identity_user_service.get_identity_user(db, identity_id)


@router.post("/", response_model=schemas.IdentityUser)
def create_identity_user(identity: schemas.IdentityUserCreate, db: Session = Depends(get_db)):
    return identity_user_service.create_identity_user(db, identity)


@router.put("/{identity_id}", response_model=schemas.IdentityUser)
def update_identity_user(identity_id: int, identity: schemas.IdentityUserCreate, db: Session = Depends(get_db)):
    return identity_user_service.update_identity_user(db, identity_id, identity)


@router.patch("/{identity_id}", response_model=schemas.IdentityUser)
def patch_identity_user(identity_id: int, identity: dict, db: Session = Depends(get_db)):
    return identity_user_service.patch_identity_user(db, identity_id, identity)


@router.delete("/{identity_id}")
def delete_identity_user(identity_id: int, db: Session = Depends(get_db)):
    return identity_user_service.delete_identity_user(db, identity_id)