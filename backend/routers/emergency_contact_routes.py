from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database.database import get_db
from schemas import schemas
from services import emergency_contact_service

router = APIRouter(prefix="/emergency_contact", tags=["Emergency Contact"])

# Get All emergency_contact
@router.get("/", response_model=list[schemas.EmergencyContact])
def read_emergency_contact(db: Session = Depends(get_db)):
    return emergency_contact_service.get_emergency_contact(db)

# Get All emergency_contact By Id
@router.get("/{emergency_contact_id}", response_model=schemas.EmergencyContact)
def read_emergency_contact(emergency_contact_id: int, db: Session = Depends(get_db)):
    return emergency_contact_service.get_emergency_contact(db, emergency_contact_id)

# Send emergency_contact Data
@router.post("/", response_model=schemas.EmergencyContact)
def create_emergency_contact(identity: schemas.EmergencyContactCreate, db: Session = Depends(get_db)):
    return emergency_contact_service.create_emergency_contact(db, identity)

# Replace / Change emergency_contact Data By Id
@router.put("/{emergency_contact_id}", response_model=schemas.EmergencyContact)
def update_emergency_contact(emergency_contact_id: int, identity: schemas.EmergencyContactCreate, db: Session = Depends(get_db)):
    return emergency_contact_service.update_emergency_contact(db, emergency_contact_id, identity)

# Update emergency_contact Data By Id
@router.patch("/{emergency_contact_id}", response_model=schemas.EmergencyContact)
def patch_emergency_contact(emergency_contact_id: int, identity: dict, db: Session = Depends(get_db)):
    return emergency_contact_service.patch_emergency_contact(db, emergency_contact_id, identity)

# Delete emergency_contact Data By Id
@router.delete("/{emergency_contact_id}")
def delete_emergency_contact(emergency_contact_id: int, db: Session = Depends(get_db)):
    return emergency_contact_service.delete_emergency_contact(db, emergency_contact_id)