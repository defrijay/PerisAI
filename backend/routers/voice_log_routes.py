from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database.database import get_db
from schemas import schemas
from services import voice_log_service

router = APIRouter(prefix="/voice_logs", tags=["Voice Logs"])

# Get All voice_log
@router.get("/", response_model=list[schemas.VoiceLog])
def read_voice_logs(db: Session = Depends(get_db)):
    return voice_log_service.get_voice_logs(db)

# Get All voice_log By Id
@router.get("/{voice_log_id}", response_model=schemas.VoiceLog)
def read_voice_log(voice_log_id: int, db: Session = Depends(get_db)):
    return voice_log_service.get_voice_log(db, voice_log_id)

# Send voice_log Data
@router.post("/", response_model=schemas.VoiceLog)
def create_voice_log(identity: schemas.VoiceLogCreate, db: Session = Depends(get_db)):
    return voice_log_service.create_voice_log(db, identity)

# Replace / Change voice_log Data By Id
@router.put("/{voice_log_id}", response_model=schemas.VoiceLog)
def update_voice_log(voice_log_id: int, identity: schemas.VoiceLogCreate, db: Session = Depends(get_db)):
    return voice_log_service.update_voice_log(db, voice_log_id, identity)

# Update voice_log Data By Id
@router.patch("/{voice_log_id}", response_model=schemas.VoiceLog)
def patch_voice_log(voice_log_id: int, identity: dict, db: Session = Depends(get_db)):
    return voice_log_service.patch_voice_log(db, voice_log_id, identity)

# Delete voice_log Data By Id
@router.delete("/{voice_log_id}")
def delete_voice_log(voice_log_id: int, db: Session = Depends(get_db)):
    return voice_log_service.delete_voice_log(db, voice_log_id)