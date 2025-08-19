from pydantic import BaseModel
from datetime import datetime, date
from typing import Optional


# ========== Identity User ==========
class IdentityUserBase(BaseModel):
    family_registration_number: int
    name: str
    place_of_birth: Optional[str] = None
    date_of_birth: Optional[str] = None
    gender: Optional[str] = None
    blood_type: Optional[str] = None
    address: Optional[str] = None
    religion: Optional[str] = None
    marital_status: Optional[str] = None
    job: Optional[str] = None
    citizenship: Optional[str] = None
    profile_picture: Optional[str] = None
    valid_until: Optional[date] = None

class IdentityUserCreate(IdentityUserBase):
    pass

class IdentityUser(IdentityUserBase):
    identity_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True


# ========== User ==========
class UserBase(BaseModel):
    fullname: str
    username: str
    phone_number: Optional[str] = None
    email: Optional[str] = None
    password: str
    profile_picture: Optional[str] = None
    urgent_number: Optional[str] = None
    identity_id: int

class UserCreate(UserBase):
    pass

class User(UserBase):
    user_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True


# ========== Voice Logs ==========
class VoiceLogBase(BaseModel):
    user_id: int
    confidence_source: Optional[str] = None
    audio_file_path: Optional[str] = None

class VoiceLogCreate(VoiceLogBase):
    pass

class VoiceLog(VoiceLogBase):
    log_id: int
    created_at: datetime

    class Config:
        orm_mode = True


# ========== Emergency Contact ==========
class EmergencyContactBase(BaseModel):
    contact_name: str
    distance: Optional[str] = None
    address: Optional[str] = None
    latitude: Optional[str] = None
    longitude: Optional[str] = None
    image_contact: Optional[str] = None
    number_contact: Optional[str] = None

class EmergencyContactCreate(EmergencyContactBase):
    pass

class EmergencyContact(EmergencyContactBase):
    emergency_contact_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True


# ========== Status Events ==========
class StatusEventBase(BaseModel):
    status_name: str
    emergency_contact_id: int
    location: Optional[str] = None
    user_id: int
    proof_image: Optional[str] = None
    voice_logs_id: Optional[int] = None
    event_type: Optional[str] = None

class StatusEventCreate(StatusEventBase):
    pass

class StatusEvent(StatusEventBase):
    status_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True


# ========== History Events ==========
class HistoryEventBase(BaseModel):
    status_id: int
    user_id: int

class HistoryEventCreate(HistoryEventBase):
    pass

class HistoryEvent(HistoryEventBase):
    history_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True


# ========== Emergency Events ==========
class EmergencyEventBase(BaseModel):
    user_id: int
    status_id: int
    latitude: Optional[str] = None
    longitude: Optional[str] = None

class EmergencyEventCreate(EmergencyEventBase):
    pass

class EmergencyEvent(EmergencyEventBase):
    emergency_events_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True
