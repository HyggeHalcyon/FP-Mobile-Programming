package entity

import (
	"github.com/google/uuid"
)

type Room struct {
	ID          uuid.UUID `json:"id" form:"id" gorm:"type:uuid;primary_key;default:uuid_generate_v4()" `
	Name        string    `json:"name" form:"name"`
	Capacity    int       `json:"capacity" form:"capacity"`
	StartHour   int       `json:"start_hour" form:"start_hour"`
	StartMinute int       `json:"start_minute" form:"start_minute"`
	EndHour     int       `json:"end_hour" form:"end_hour"`
	EndMinute   int       `json:"end_minute" form:"end_minute"`

	Timestamp
}
