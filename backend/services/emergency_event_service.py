from sqlalchemy.orm import Session
from fastapi import Depends, HTTPException
from database.database import get_db
from models import models
from schemas import schemas
from services.base_service import update_instance

def get_emergency_events(db: Session = Depends(get_db)):
    return db.query(models.EmergencyEvent).all()

def get_emergency_event(event_id: int, db: Session = Depends(get_db)):
    db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Emergency event not found")
    return db_event

def create_emergency_event(event: schemas.EmergencyEventCreate, db: Session = Depends(get_db)):
    db_event = models.EmergencyEvent(**event.dict())
    db.add(db_event)
    db.commit()
    db.refresh(db_event)
    return db_event

def update_emergency_event(event_id: int, event: schemas.EmergencyEventCreate, db: Session = Depends(get_db)):
    db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Emergency event not found")
    db_event = update_instance(db_event, event.dict())
    db.commit()
    db.refresh(db_event)
    return db_event

def patch_emergency_event(event_id: int, event: dict, db: Session = Depends(get_db)):
    db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Emergency event not found")
    db_event = update_instance(db_event, event)
    db.commit()
    db.refresh(db_event)
    return db_event

def delete_emergency_event(event_id: int, db: Session = Depends(get_db)):
    db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
    if not db_event:
        raise HTTPException(status_code=404, detail="Emergency event not found")
    db.delete(db_event)
    db.commit()
    return {"message": "Emergency event deleted successfully"}