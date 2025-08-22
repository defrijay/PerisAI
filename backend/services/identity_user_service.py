from sqlalchemy.orm import Session
from fastapi import HTTPException
from models import models
from schemas import schemas


def get_identity_users(db: Session):
    return db.query(models.IdentityUser).all()


def get_identity_user(db: Session, identity_id: int):
    identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
    if not identity:
        raise HTTPException(status_code=404, detail="Identity user not found")
    return identity


def create_identity_user(db: Session, identity: schemas.IdentityUserCreate):
    db_identity = models.IdentityUser(**identity.dict())
    db.add(db_identity)
    db.commit()
    db.refresh(db_identity)
    return db_identity


def update_identity_user(db: Session, identity_id: int, identity: schemas.IdentityUserCreate):
    db_identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
    if not db_identity:
        raise HTTPException(status_code=404, detail="Identity user not found")
    for key, value in identity.dict().items():
        setattr(db_identity, key, value)
    db.commit()
    db.refresh(db_identity)
    return db_identity


def patch_identity_user(db: Session, identity_id: int, identity: dict):
    db_identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
    if not db_identity:
        raise HTTPException(status_code=404, detail="Identity user not found")
    for key, value in identity.items():
        setattr(db_identity, key, value)
    db.commit()
    db.refresh(db_identity)
    return db_identity


def delete_identity_user(db: Session, identity_id: int):
    db_identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
    if not db_identity:
        raise HTTPException(status_code=404, detail="Identity user not found")
    db.delete(db_identity)
    db.commit()
    return {"message": "Identity user deleted successfully"}
