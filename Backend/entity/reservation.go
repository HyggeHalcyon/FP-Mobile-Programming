package entity

import (
	"Tekber-BE/dto"
	"encoding/json"
	"time"

	"github.com/google/uuid"
)

type Reservation struct {
	ID     uuid.UUID `json:"id" form:"id" gorm:"type:uuid;primary_key;default:uuid_generate_v4()" `
	UserID uuid.UUID `json:"user_id" form:"user_id" gorm:"foreignKey"`
	RoomID uuid.UUID `json:"room_id" form:"room_id" gorm:"foreignKey"`
	Status string    `json:"status" form:"status"`

	StartDate time.Time `json:"start_date" form:"start_date"`
	EndDate   time.Time `json:"end_date" form:"end_date"`

	Timestamp
}

func (r *Reservation) UnmarshalJSON(data []byte) error {
	type Alias Reservation
	aux := &struct {
		StartDate string `json:"start_date"`
		EndDate   string `json:"end_date"`
		*Alias
	}{
		Alias: (*Alias)(r),
	}

	if err := json.Unmarshal(data, &aux); err != nil {
		return err
	}

	startDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, aux.StartDate)
	if err != nil {
		return err
	}

	endDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, aux.EndDate)
	if err != nil {
		return err
	}

	r.StartDate = startDate
	r.EndDate = endDate
	return nil
}
