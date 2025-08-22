from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database.database import get_db
from schemas import schemas
from services import emergency_event_service

router = APIRouter(prefix="/emergency-event", tags=["Emergency Event"])

# Get All Emergency Event
@router.get("/", response_model=list[schemas.EmergencyEvent])
def get_emergency_event(db: Session = Depends(get_db)):
    return emergency_event_service.get_emergency_event(db)

# Get All Emergency Event By Id
@router.get("/{emergency_events_id}", response_model=schemas.EmergencyEvent)
def get_emergency_event(emergency_events_id: int, db: Session = Depends(get_db)):
    return emergency_event_service.get_emergency_event(db, emergency_events_id)

# Send Emergency Event Data
@router.post("/", response_model=schemas.EmergencyEvent)
def create_emergency_event(identity: schemas.EmergencyEventCreate, db: Session = Depends(get_db)):
    return emergency_event_service.create_emergency_event(db, identity)

# Replace / Change Emergency Event Data By Id
@router.put("/{emergency_events_id}", response_model=schemas.EmergencyEvent)
def update_emergency_event(emergency_events_id: int, identity: schemas.EmergencyEventCreate, db: Session = Depends(get_db)):
    return emergency_event_service.update_emergency_event(db, emergency_events_id, identity)

# Update Emergency Event Data By Id
@router.patch("/{emergency_events_id}", response_model=schemas.EmergencyEvent)
def patch_emergency_event(emergency_events_id: int, identity: dict, db: Session = Depends(get_db)):
    return emergency_event_service.patch_emergency_event(db, emergency_events_id, identity)

# Delete Emergency Event Data By Id
@router.delete("/{emergency_events_id}")
def delete_emergency_event(emergency_events_id: int, db: Session = Depends(get_db)):
    return emergency_event_service.delete_emergency_event(db, emergency_events_id)