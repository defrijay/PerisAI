from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database.database import get_db
from schemas import schemas
from services import status_events_service

router = APIRouter(prefix="/status-event", tags=["Status Event"])

# Get All Status Event
@router.get("/", response_model=list[schemas.StatusEvent])
def read_status_event(db: Session = Depends(get_db)):
    return status_events_service.get_status_event(db)

# Get All Status Event By Id
@router.get("/{status_event}", response_model=schemas.StatusEvent)
def read_status_event(status_event: int, db: Session = Depends(get_db)):
    return status_events_service.get_status_event(db, status_event)

# Send Status Event Data
@router.post("/", response_model=schemas.StatusEvent)
def create_status_event(identity: schemas.StatusEventCreate, db: Session = Depends(get_db)):
    return status_events_service.create_status_event(db, identity)

# Replace / Change status_event Data By Id
@router.put("/{status_event}", response_model=schemas.StatusEvent)
def update_status_event(status_event: int, identity: schemas.StatusEventCreate, db: Session = Depends(get_db)):
    return status_events_service.update_status_event(db, status_event, identity)

# Update Status Event Data By Id
@router.patch("/{status_event}", response_model=schemas.StatusEvent)
def patch_status_event(status_event: int, identity: dict, db: Session = Depends(get_db)):
    return status_events_service.patch_status_event(db, status_event, identity)

# Delete Status Event Data By Id
@router.delete("/{status_event}")
def delete_status_event(status_event: int, db: Session = Depends(get_db)):
    return status_events_service.delete_status_event(db, status_event)