from sqlalchemy.orm import Session
from fastapi import Depends, HTTPException
from models import models
from schemas import schemas
from database.database import get_db
from services.base_service import update_instance

# ========== EmergencyContact ==========
def read_emergency_contacts(db: Session = Depends(get_db)):
    return db.query(models.EmergencyContact).all()

def read_emergency_contact(contact_id: int, db: Session = Depends(get_db)):
    db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
    if not db_contact:
        raise HTTPException(status_code=404, detail="Emergency contact not found")
    return db_contact

def create_emergency_contact(contact: schemas.EmergencyContactCreate, db: Session = Depends(get_db)):
    db_contact = models.EmergencyContact(**contact.dict())
    db.add(db_contact)
    db.commit()
    db.refresh(db_contact)
    return db_contact

def update_emergency_contact(contact_id: int, contact: schemas.EmergencyContactCreate, db: Session = Depends(get_db)):
    db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
    if not db_contact:
        raise HTTPException(status_code=404, detail="Emergency contact not found")
    db_contact = update_instance(db_contact, contact.dict())
    db.commit()
    db.refresh(db_contact)
    return db_contact

def patch_emergency_contact(contact_id: int, contact: dict, db: Session = Depends(get_db)):
    db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
    if not db_contact:
        raise HTTPException(status_code=404, detail="Emergency contact not found")
    db_contact = update_instance(db_contact, contact)
    db.commit()
    db.refresh(db_contact)
    return db_contact

def delete_emergency_contact(contact_id: int, db: Session = Depends(get_db)):
    db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
    if not db_contact:
        raise HTTPException(status_code=404, detail="Emergency contact not found")
    db.delete(db_contact)
    db.commit()
    return {"message": "Emergency contact deleted successfully"}
