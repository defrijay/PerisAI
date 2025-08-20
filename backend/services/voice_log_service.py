from sqlalchemy.orm import Session
from fastapi import Depends, HTTPException
from database.database import get_db
from models import models
from schemas import schemas
from services.base_service import update_instance

# ========== VoiceLogs ==========
def read_voice_logs(db: Session = Depends(get_db)):
    return db.query(models.VoiceLog).all()

def read_voice_log(log_id: int, db: Session = Depends(get_db)):
    db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
    if not db_log:
        raise HTTPException(status_code=404, detail="Voice log not found")
    return db_log

def create_voice_log(log: schemas.VoiceLogCreate, db: Session = Depends(get_db)):
    db_log = models.VoiceLog(**log.dict())
    db.add(db_log)
    db.commit()
    db.refresh(db_log)
    return db_log

def update_voice_log(log_id: int, log: schemas.VoiceLogCreate, db: Session = Depends(get_db)):
    db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
    if not db_log:
        raise HTTPException(status_code=404, detail="Voice log not found")
    db_log = update_instance(db_log, log.dict())
    db.commit()
    db.refresh(db_log)
    return db_log

def patch_voice_log(log_id: int, log: dict, db: Session = Depends(get_db)):
    db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
    if not db_log:
        raise HTTPException(status_code=404, detail="Voice log not found")
    db_log = update_instance(db_log, log)
    db.commit()
    db.refresh(db_log)
    return db_log

def delete_voice_log(log_id: int, db: Session = Depends(get_db)):
    db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
    if not db_log:
        raise HTTPException(status_code=404, detail="Voice log not found")
    db.delete(db_log)
    db.commit()
    return {"message": "Voice log deleted successfully"}