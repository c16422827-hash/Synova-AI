"""
Message-related Pydantic models.

This module contains Pydantic models for message-related operations.
"""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel, Field


class MessageBase(BaseModel):
    """Base model for message with common attributes."""
    tier: str = Field(..., description="Message category/classification")
    query: str = Field(..., description="The user's input query")
    response: Optional[str] = Field(None, description="System's response to the query")


class MessageCreate(MessageBase):
    """Model for creating a new message."""
    pass


class MessageResponse(MessageBase):
    """Model for message response."""
    id: int
    timestamp: datetime

    class Config:
        orm_mode = True
