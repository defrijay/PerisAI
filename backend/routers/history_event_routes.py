from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database.database import get_db
from schemas import schemas
from services import history_event_service

router = APIRouter(prefix="/history-event", tags=["History Event"])

# Get All History
@router.get("/", response_model=list[schemas.HistoryEvent])
def read_history_event(db: Session = Depends(get_db)):
    return history_event_service.get_history_event(db)

# Get All History By Id
@router.get("/{history_id}", response_model=schemas.HistoryEvent)
def read_history_event(history_id: int, db: Session = Depends(get_db)):
    return history_event_service.get_history_event(db, history_id)

# Send History Data
@router.post("/", response_model=schemas.HistoryEvent)
def create_history_event(identity: schemas.HistoryEventCreate, db: Session = Depends(get_db)):
    return history_event_service.create_history_event(db, identity)

# Replace / Change History Data By Id
@router.put("/{history_id}", response_model=schemas.HistoryEvent)
def update_history_event(history_id: int, identity: schemas.HistoryEventCreate, db: Session = Depends(get_db)):
    return history_event_service.update_history_event(db, history_id, identity)

# Update History Data By Id
@router.patch("/{history_id}", response_model=schemas.HistoryEvent)
def patch_history_event(history_id: int, identity: dict, db: Session = Depends(get_db)):
    return history_event_service.patch_history_event(db, history_id, identity)

# Delete History Data By Id
@router.delete("/{history_id}")
def delete_history_event(history_id: int, db: Session = Depends(get_db)):
    return history_event_service.delete_history_event(db, history_id)