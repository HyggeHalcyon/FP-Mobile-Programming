package repository

import (
	"Tekber-BE/entity"

	"gorm.io/gorm"
)

type (
	FacilityRepository interface {
		GetByRoomID(string) ([]entity.Facility, error)
	}

	facilityRepository struct {
		db *gorm.DB
	}
)

func NewFacilityRepository(db *gorm.DB) FacilityRepository {
	return &facilityRepository{
		db: db,
	}
}

func (r *facilityRepository) GetByRoomID(roomID string) ([]entity.Facility, error) {
	var facilities []entity.Facility

	err := r.db.Where("room_id = ?", roomID).Find(&facilities).Error
	if err != nil {
		return nil, err
	}

	return facilities, nil
}
