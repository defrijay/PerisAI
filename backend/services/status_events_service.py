from sqlalchemy.orm import Session
from fastapi import Depends, HTTPException
from database.database import get_db
from models import models
from schemas import schemas
from services.base_service import update_instance

def read_status_events(db: Session = Depends(get_db)):
    return db.query(models.StatusEvent).all()

def read_status_event(status_id: int, db: Session = Depends(get_db)):
    db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Status event not found")
    return db_event

def create_status_event(event: schemas.StatusEventCreate, db: Session = Depends(get_db)):
    db_event = models.StatusEvent(**event.dict())
    db.add(db_event)
    db.commit()
    db.refresh(db_event)
    return db_event

def update_status_event(status_id: int, event: schemas.StatusEventCreate, db: Session = Depends(get_db)):
    db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Status event not found")
    db_event = update_instance(db_event, event.dict())
    db.commit()
    db.refresh(db_event)
    return db_event

def patch_status_event(status_id: int, event: dict, db: Session = Depends(get_db)):
    db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Status event not found")
    db_event = update_instance(db_event, event)
    db.commit()
    db.refresh(db_event)
    return db_event

def delete_status_event(status_id: int, db: Session = Depends(get_db)):
    db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Status event not found")
    db.delete(db_event)
    db.commit()
    return {"message": "Status event deleted successfully"}