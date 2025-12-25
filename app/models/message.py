from datetime import datetime
from enum import Enum
from typing import Optional

from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy import Column, DateTime, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.database import Base

class MessageTier(str, Enum):
    TERRESTRIAL = "terrestrial"
    CELESTIAL = "celestial"
    GALACTIC = "galactic"

class Message(Base):
    """Message model for storing chat messages"""
    __tablename__ = "messages"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    tier: Mapped[str] = mapped_column(
        String(20), 
        nullable=False, 
        default=MessageTier.TERRESTRIAL
    )
    query: Mapped[str] = mapped_column(Text, nullable=False)
    response: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    created_at: Mapped[datetime] = mapped_column(
        DateTime, 
        default=datetime.utcnow, 
        nullable=False
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime, 
        default=datetime.utcnow, 
        onupdate=datetime.utcnow, 
        nullable=False
    )

    def __repr__(self) -> str:
        return f"<Message(id={self.id}, tier={self.tier}, created_at={self.created_at})>"

# Pydantic models for request/response
class MessageBase(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    
    tier: MessageTier = MessageTier.TERRESTRIAL
    query: str

class MessageCreate(MessageBase):
    pass

class MessageUpdate(BaseModel):
    response: str

class MessageInDB(MessageBase):
    model_config = ConfigDict(from_attributes=True)
    
    id: int
    response: Optional[str] = None
    created_at: datetime
    updated_at: datetime

# Response models
class MessageResponse(MessageInDB):
    """Response model for message endpoints."""
    pass
