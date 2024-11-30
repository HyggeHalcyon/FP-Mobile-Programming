package entity

import (
	"time"

	"github.com/google/uuid"
)

type Reservation struct {
	ID     uuid.UUID `json:"id" form:"id" gorm:"type:uuid;primary_key;default:uuid_generate_v4()" `
	UserID uuid.UUID `json:"user" form:"user" gorm:"foreignKey"`
	RoomID uuid.UUID `json:"room" form:"room" gorm:"foreignKey"`

	StartDate time.Time `json:"start_date" form:"start_date"`
	EndDate   time.Time `json:"end_date" form:"end_date"`

	Timestamp
}
