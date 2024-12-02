package entity

import (
	"github.com/google/uuid"
)

type Room struct {
	ID       uuid.UUID `json:"id" form:"id" gorm:"type:uuid;primary_key;default:uuid_generate_v4()" `
	Name     string    `json:"name" form:"name"`
	Capacity int       `json:"capacity" form:"capacity"`
	Location string    `json:"location" form:"location"`
	Picture  string    `json:"picture" form:"picture"`

	Timestamp
}
