package entity

import "github.com/google/uuid"

type Facility struct {
	ID     uuid.UUID `json:"id" form:"id" gorm:"type:uuid;primary_key;default:uuid_generate_v4()" `
	RoomID uuid.UUID `json:"room_id" form:"room_id"`
	Name   string    `json:"name" form:"name"`

	Timestamp
}
