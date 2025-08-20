from sqlalchemy.orm import Session
from fastapi import Depends, HTTPException
from database.database import get_db
from models import models
from schemas import schemas
from services.base_service import update_instance

def get_history_events(db: Session = Depends(get_db)):
    return db.query(models.HistoryEvent).all()

def get_history_event(history_id: int, db: Session = Depends(get_db)):
    db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
    if not db_history:
        raise HTTPException(status_code=404, detail="History event not found")
    return db_history

def create_history_event(history: schemas.HistoryEventCreate, db: Session = Depends(get_db)):
    db_history = models.HistoryEvent(**history.dict())
    db.add(db_history)
    db.commit()
    db.refresh(db_history)
    return db_history

def update_history_event(history_id: int, history: schemas.HistoryEventCreate, db: Session = Depends(get_db)):
    db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
    if not db_history:
        raise HTTPException(status_code=404, detail="History event not found")
    db_history = update_instance(db_history, history.dict())
    db.commit()
    db.refresh(db_history)
    return db_history

def patch_history_event(history_id: int, history: dict, db: Session = Depends(get_db)):
    db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
    if not db_history:
        raise HTTPException(status_code=404, detail="History event not found")
    db_history = update_instance(db_history, history)
    db.commit()
    db.refresh(db_history)
    return db_history

def delete_history_event(history_id: int, db: Session = Depends(get_db)):
    db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
    if not db_history:
        raise HTTPException(status_code=404, detail="History event not found")
    db.delete(db_history)
    db.commit()
    return {"message": "History event deleted successfully"}
