from sqlalchemy import Column, Integer, String, ForeignKey, Date, DateTime
from sqlalchemy.orm import relationship
from database.database import Base
from datetime import datetime


class IdentityUser(Base):
    __tablename__ = "identity_user"

    identity_id = Column(Integer, primary_key=True, index=True)
    family_registration_number = Column(Integer, unique=True, nullable=False)
    name = Column(String, nullable=False)
    place_of_birth = Column(String)
    date_of_birth = Column(String)
    gender = Column(String)
    blood_type = Column(String)
    address = Column(String)
    religion = Column(String)
    marital_status = Column(String)
    job = Column(String)
    citizenship = Column(String)
    profile_picture = Column(String)
    valid_until = Column(Date)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow)

    users = relationship("User", back_populates="identity")


class User(Base):
    __tablename__ = "user"

    user_id = Column(Integer, primary_key=True, index=True)
    fullname = Column(String, unique=True, nullable=False)
    username = Column(String, unique=True, nullable=False)
    phone_number = Column(String)
    email = Column(String)
    password = Column(String)
    profile_picture = Column(String)
    urgent_number = Column(String)
    identity_id = Column(Integer, ForeignKey("identity_user.identity_id"))
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow)

    identity = relationship("IdentityUser", back_populates="users")
    voice_logs = relationship("VoiceLog", back_populates="user")
    status_events = relationship("StatusEvent", back_populates="user")
    history_events = relationship("HistoryEvent", back_populates="user")
    emergency_events = relationship("EmergencyEvent", back_populates="user")


class VoiceLog(Base):
    __tablename__ = "voice_logs"

    log_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.user_id"))
    confidence_source = Column(String)
    audio_file_path = Column(String)
    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="voice_logs")
    status_events = relationship("StatusEvent", back_populates="voice_log")


class EmergencyContact(Base):
    __tablename__ = "emergency_contact"

    emergency_contact_id = Column(Integer, primary_key=True, index=True)
    contact_name = Column(String)
    distance = Column(String)
    address = Column(String)
    latitude = Column(String)
    longitude = Column(String)
    image_contact = Column(String)
    number_contact = Column(String)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow)

    status_events = relationship("StatusEvent", back_populates="emergency_contact")


class StatusEvent(Base):
    __tablename__ = "status_events"

    status_id = Column(Integer, primary_key=True, index=True)
    status_name = Column(String)
    emergency_contact_id = Column(Integer, ForeignKey("emergency_contact.emergency_contact_id"))
    location = Column(String)
    user_id = Column(Integer, ForeignKey("user.user_id"))
    proof_image = Column(String)
    voice_logs_id = Column(Integer, ForeignKey("voice_logs.log_id"))
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow)
    event_type = Column(String)

    user = relationship("User", back_populates="status_events")
    emergency_contact = relationship("EmergencyContact", back_populates="status_events")
    voice_log = relationship("VoiceLog", back_populates="status_events")
    history_events = relationship("HistoryEvent", back_populates="status_event")
    emergency_events = relationship("EmergencyEvent", back_populates="status_event")


class HistoryEvent(Base):
    __tablename__ = "history_events"

    history_id = Column(Integer, primary_key=True, index=True)
    status_id = Column(Integer, ForeignKey("status_events.status_id"))
    user_id = Column(Integer, ForeignKey("user.user_id"))
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow)

    status_event = relationship("StatusEvent", back_populates="history_events")
    user = relationship("User", back_populates="history_events")


class EmergencyEvent(Base):
    __tablename__ = "emergency_events"

    emergency_events_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.user_id"))
    status_id = Column(Integer, ForeignKey("status_events.status_id"))
    latitude = Column(String)
    longitude = Column(String)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="emergency_events")
    status_event = relationship("StatusEvent", back_populates="emergency_events")
