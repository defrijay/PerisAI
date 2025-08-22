from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from database.database import get_db
from models import models
from schemas import schemas
from database.database import engine, SessionLocal
from routers import (
    identity_user_routes,
    user_routes,
    voice_log_routes,
    emergency_contact_routes,
    status_event_routes,
    history_event_routes,
    emergency_event_routes,
)

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/")
def root():
    return {"message": "FastAPI backend is running 🚀"}


# Register Routes
app.include_router(identity_user_routes.router)
app.include_router(user_routes.router)
app.include_router(voice_log_routes.router)
app.include_router(emergency_contact_routes.router)
app.include_router(status_event_routes.router)
app.include_router(history_event_routes.router)
app.include_router(emergency_event_routes.router)

# Old Register Routes
# app.include_router(user_routes.router, prefix="/users", tags=["Users"])
# app.include_router(voice_log_routes.router, prefix="/voice_logs", tags=["Voice Logs"])
# app.include_router(status_event_routes.router, prefix="/emergency_contacts", tags=["Emergency Contacts"])
# app.include_router(status_event_routes.router, prefix="/status_events", tags=["Status Events"])
# app.include_router(history_event_routes.router, prefix="/history_events", tags=["History Events"])
# app.include_router(emergency_event_routes.router, prefix="/emergency_events", tags=["Emergency Events"])


# ========== CRUD GENERIC HELPER ==========
def update_instance(db_obj, update_data: dict):
    for key, value in update_data.items():
        setattr(db_obj, key, value)
    return db_obj


# # ========== IdentityUser ==========
# @app.get("/identity_users", response_model=list[schemas.IdentityUser])
# def read_identity_users(db: Session = Depends(get_db)):
#     return db.query(models.IdentityUser).all()

# @app.get("/identity_users/{identity_id}", response_model=schemas.IdentityUser)
# def read_identity_user(identity_id: int, db: Session = Depends(get_db)):
#     db_identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
#     if not db_identity:
#         raise HTTPException(status_code=404, detail="Identity user not found")
#     return db_identity

# @app.post("/identity_users", response_model=schemas.IdentityUser)
# def create_identity_user(identity: schemas.IdentityUserCreate, db: Session = Depends(get_db)):
#     db_identity = models.IdentityUser(**identity.dict())
#     db.add(db_identity)
#     db.commit()
#     db.refresh(db_identity)
#     return db_identity

# @app.put("/identity_users/{identity_id}", response_model=schemas.IdentityUser)
# def update_identity_user(identity_id: int, identity: schemas.IdentityUserCreate, db: Session = Depends(get_db)):
#     db_identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
#     if not db_identity:
#         raise HTTPException(status_code=404, detail="Identity user not found")
#     db_identity = update_instance(db_identity, identity.dict())
#     db.commit()
#     db.refresh(db_identity)
#     return db_identity


# @app.patch("/identity_users/{identity_id}", response_model=schemas.IdentityUser)
# def patch_identity_user(identity_id: int, identity: dict, db: Session = Depends(get_db)):
#     db_identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
#     if not db_identity:
#         raise HTTPException(status_code=404, detail="Identity user not found")
#     db_identity = update_instance(db_identity, identity)
#     db.commit()
#     db.refresh(db_identity)
#     return db_identity


# @app.delete("/identity_users/{identity_id}")
# def delete_identity_user(identity_id: int, db: Session = Depends(get_db)):
#     db_identity = db.query(models.IdentityUser).filter(models.IdentityUser.identity_id == identity_id).first()
#     if not db_identity:
#         raise HTTPException(status_code=404, detail="Identity user not found")
#     db.delete(db_identity)
#     db.commit()
#     return {"message": "Identity user deleted successfully"}

# # ========== User ==========
# @app.get("/users", response_model=list[schemas.User])
# def read_users(db: Session = Depends(get_db)):
#     return db.query(models.User).all()

# @app.get("/users/{user_id}", response_model=schemas.User)
# def read_user(user_id: int, db: Session = Depends(get_db)):
#     db_user = db.query(models.User).filter(models.User.user_id == user_id).first()
#     if not db_user:
#         raise HTTPException(status_code=404, detail="User not found")
#     return db_user

# @app.post("/users", response_model=schemas.User)
# def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
#     db_user = models.User(**user.dict())
#     db.add(db_user)
#     db.commit()
#     db.refresh(db_user)
#     return db_user

# @app.put("/users/{user_id}", response_model=schemas.User)
# def update_user(user_id: int, user: schemas.UserCreate, db: Session = Depends(get_db)):
#     db_user = db.query(models.User).filter(models.User.user_id == user_id).first()
#     if not db_user:
#         raise HTTPException(status_code=404, detail="User not found")
#     db_user = update_instance(db_user, user.dict())
#     db.commit()
#     db.refresh(db_user)
#     return db_user


# @app.patch("/users/{user_id}", response_model=schemas.User)
# def patch_user(user_id: int, user: dict, db: Session = Depends(get_db)):
#     db_user = db.query(models.User).filter(models.User.user_id == user_id).first()
#     if not db_user:
#         raise HTTPException(status_code=404, detail="User not found")
#     db_user = update_instance(db_user, user)
#     db.commit()
#     db.refresh(db_user)
#     return db_user


# @app.delete("/users/{user_id}")
# def delete_user(user_id: int, db: Session = Depends(get_db)):
#     db_user = db.query(models.User).filter(models.User.user_id == user_id).first()
#     if not db_user:
#         raise HTTPException(status_code=404, detail="User not found")
#     db.delete(db_user)
#     db.commit()
#     return {"message": "User deleted successfully"}


# # ========== VoiceLogs ==========
# @app.get("/voice_logs", response_model=list[schemas.VoiceLog])
# def read_voice_logs(db: Session = Depends(get_db)):
#     return db.query(models.VoiceLog).all()

# @app.get("/voice_logs/{log_id}", response_model=schemas.VoiceLog)
# def read_voice_log(log_id: int, db: Session = Depends(get_db)):
#     db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
#     if not db_log:
#         raise HTTPException(status_code=404, detail="Voice log not found")
#     return db_log

# @app.post("/voice_logs", response_model=schemas.VoiceLog)
# def create_voice_log(log: schemas.VoiceLogCreate, db: Session = Depends(get_db)):
#     db_log = models.VoiceLog(**log.dict())
#     db.add(db_log)
#     db.commit()
#     db.refresh(db_log)
#     return db_log

# @app.put("/voice_logs/{log_id}", response_model=schemas.VoiceLog)
# def update_voice_log(log_id: int, log: schemas.VoiceLogCreate, db: Session = Depends(get_db)):
#     db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
#     if not db_log:
#         raise HTTPException(status_code=404, detail="Voice log not found")
#     db_log = update_instance(db_log, log.dict())
#     db.commit()
#     db.refresh(db_log)
#     return db_log


# @app.patch("/voice_logs/{log_id}", response_model=schemas.VoiceLog)
# def patch_voice_log(log_id: int, log: dict, db: Session = Depends(get_db)):
#     db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
#     if not db_log:
#         raise HTTPException(status_code=404, detail="Voice log not found")
#     db_log = update_instance(db_log, log)
#     db.commit()
#     db.refresh(db_log)
#     return db_log


# @app.delete("/voice_logs/{log_id}")
# def delete_voice_log(log_id: int, db: Session = Depends(get_db)):
#     db_log = db.query(models.VoiceLog).filter(models.VoiceLog.log_id == log_id).first()
#     if not db_log:
#         raise HTTPException(status_code=404, detail="Voice log not found")
#     db.delete(db_log)
#     db.commit()
#     return {"message": "Voice log deleted successfully"}


# # ========== EmergencyContact ==========
# @app.get("/emergency_contacts", response_model=list[schemas.EmergencyContact])
# def read_emergency_contacts(db: Session = Depends(get_db)):
#     return db.query(models.EmergencyContact).all()

# @app.get("/emergency_contacts/{contact_id}", response_model=schemas.EmergencyContact)
# def read_emergency_contact(contact_id: int, db: Session = Depends(get_db)):
#     db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
#     if not db_contact:
#         raise HTTPException(status_code=404, detail="Emergency contact not found")
#     return db_contact

# @app.post("/emergency_contacts", response_model=schemas.EmergencyContact)
# def create_emergency_contact(contact: schemas.EmergencyContactCreate, db: Session = Depends(get_db)):
#     db_contact = models.EmergencyContact(**contact.dict())
#     db.add(db_contact)
#     db.commit()
#     db.refresh(db_contact)
#     return db_contact

# @app.put("/emergency_contacts/{contact_id}", response_model=schemas.EmergencyContact)
# def update_emergency_contact(contact_id: int, contact: schemas.EmergencyContactCreate, db: Session = Depends(get_db)):
#     db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
#     if not db_contact:
#         raise HTTPException(status_code=404, detail="Emergency contact not found")
#     db_contact = update_instance(db_contact, contact.dict())
#     db.commit()
#     db.refresh(db_contact)
#     return db_contact

# @app.patch("/emergency_contacts/{contact_id}", response_model=schemas.EmergencyContact)
# def patch_emergency_contact(contact_id: int, contact: dict, db: Session = Depends(get_db)):
#     db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
#     if not db_contact:
#         raise HTTPException(status_code=404, detail="Emergency contact not found")
#     db_contact = update_instance(db_contact, contact)
#     db.commit()
#     db.refresh(db_contact)
#     return db_contact


# @app.delete("/emergency_contacts/{contact_id}")
# def delete_emergency_contact(contact_id: int, db: Session = Depends(get_db)):
#     db_contact = db.query(models.EmergencyContact).filter(models.EmergencyContact.emergency_contact_id == contact_id).first()
#     if not db_contact:
#         raise HTTPException(status_code=404, detail="Emergency contact not found")
#     db.delete(db_contact)
#     db.commit()
#     return {"message": "Emergency contact deleted successfully"}


# # ========== StatusEvents ==========
# @app.get("/status_events", response_model=list[schemas.StatusEvent])
# def read_status_events(db: Session = Depends(get_db)):
#     return db.query(models.StatusEvent).all()

# @app.get("/status_events/{status_id}", response_model=schemas.StatusEvent)
# def read_status_event(status_id: int, db: Session = Depends(get_db)):
#     db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Status event not found")
#     return db_event

# @app.post("/status_events", response_model=schemas.StatusEvent)
# def create_status_event(event: schemas.StatusEventCreate, db: Session = Depends(get_db)):
#     db_event = models.StatusEvent(**event.dict())
#     db.add(db_event)
#     db.commit()
#     db.refresh(db_event)
#     return db_event

# @app.put("/status_events/{status_id}", response_model=schemas.StatusEvent)
# def update_status_event(status_id: int, event: schemas.StatusEventCreate, db: Session = Depends(get_db)):
#     db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Status event not found")
#     db_event = update_instance(db_event, event.dict())
#     db.commit()
#     db.refresh(db_event)
#     return db_event


# @app.patch("/status_events/{status_id}", response_model=schemas.StatusEvent)
# def patch_status_event(status_id: int, event: dict, db: Session = Depends(get_db)):
#     db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Status event not found")
#     db_event = update_instance(db_event, event)
#     db.commit()
#     db.refresh(db_event)
#     return db_event


# @app.delete("/status_events/{status_id}")
# def delete_status_event(status_id: int, db: Session = Depends(get_db)):
#     db_event = db.query(models.StatusEvent).filter(models.StatusEvent.status_id == status_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Status event not found")
#     db.delete(db_event)
#     db.commit()
#     return {"message": "Status event deleted successfully"}


# # ========== HistoryEvents ==========
# @app.get("/history_events", response_model=list[schemas.HistoryEvent])
# def read_history_events(db: Session = Depends(get_db)):
#     return db.query(models.HistoryEvent).all()

# @app.get("/history_events/{history_id}", response_model=schemas.HistoryEvent)
# def read_history_event(history_id: int, db: Session = Depends(get_db)):
#     db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
#     if not db_history:
#         raise HTTPException(status_code=404, detail="History event not found")
#     return db_history

# @app.post("/history_events", response_model=schemas.HistoryEvent)
# def create_history_event(history: schemas.HistoryEventCreate, db: Session = Depends(get_db)):
#     db_history = models.HistoryEvent(**history.dict())
#     db.add(db_history)
#     db.commit()
#     db.refresh(db_history)
#     return db_history

# @app.put("/history_events/{history_id}", response_model=schemas.HistoryEvent)
# def update_history_event(history_id: int, history: schemas.HistoryEventCreate, db: Session = Depends(get_db)):
#     db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
#     if not db_history:
#         raise HTTPException(status_code=404, detail="History event not found")
#     db_history = update_instance(db_history, history.dict())
#     db.commit()
#     db.refresh(db_history)
#     return db_history

# @app.patch("/history_events/{history_id}", response_model=schemas.HistoryEvent)
# def patch_history_event(history_id: int, history: dict, db: Session = Depends(get_db)):
#     db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
#     if not db_history:
#         raise HTTPException(status_code=404, detail="History event not found")
#     db_history = update_instance(db_history, history)
#     db.commit()
#     db.refresh(db_history)
#     return db_history


# @app.delete("/history_events/{history_id}")
# def delete_history_event(history_id: int, db: Session = Depends(get_db)):
#     db_history = db.query(models.HistoryEvent).filter(models.HistoryEvent.history_id == history_id).first()
#     if not db_history:
#         raise HTTPException(status_code=404, detail="History event not found")
#     db.delete(db_history)
#     db.commit()
#     return {"message": "History event deleted successfully"}


# # ========== EmergencyEvents ==========
# @app.get("/emergency_events", response_model=list[schemas.EmergencyEvent])
# def read_emergency_events(db: Session = Depends(get_db)):
#     return db.query(models.EmergencyEvent).all()

# @app.get("/emergency_events/{event_id}", response_model=schemas.EmergencyEvent)
# def read_emergency_event(event_id: int, db: Session = Depends(get_db)):
#     db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Emergency event not found")
#     return db_event

# @app.post("/emergency_events", response_model=schemas.EmergencyEvent)
# def create_emergency_event(event: schemas.EmergencyEventCreate, db: Session = Depends(get_db)):
#     db_event = models.EmergencyEvent(**event.dict())
#     db.add(db_event)
#     db.commit()
#     db.refresh(db_event)
#     return db_event

# @app.put("/emergency_events/{event_id}", response_model=schemas.EmergencyEvent)
# def update_emergency_event(event_id: int, event: schemas.EmergencyEventCreate, db: Session = Depends(get_db)):
#     db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Emergency event not found")
#     db_event = update_instance(db_event, event.dict())
#     db.commit()
#     db.refresh(db_event)
#     return db_event


# @app.patch("/emergency_events/{event_id}", response_model=schemas.EmergencyEvent)
# def patch_emergency_event(event_id: int, event: dict, db: Session = Depends(get_db)):
#     db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Emergency event not found")
#     db_event = update_instance(db_event, event)
#     db.commit()
#     db.refresh(db_event)
#     return db_event


# @app.delete("/emergency_events/{event_id}")
# def delete_emergency_event(event_id: int, db: Session = Depends(get_db)):
#     db_event = db.query(models.EmergencyEvent).filter(models.EmergencyEvent.emergency_events_id == event_id).first()
#     if not db_event:
#         raise HTTPException(status_code=404, detail="Emergency event not found")
#     db.delete(db_event)
#     db.commit()
#     return {"message": "Emergency event deleted successfully"}
