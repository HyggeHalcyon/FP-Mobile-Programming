package repository

import (
	"Tekber-BE/entity"
	"time"

	"gorm.io/gorm"
)

type (
	RerservationRepository interface {
		GetByIDAndAfterStartDate(string, time.Time) ([]entity.Reservation, error)
		Create(entity.Reservation) (entity.Reservation, error)
	}

	rerservationRepository struct {
		db *gorm.DB
	}
)

func NewReservationRepository(db *gorm.DB) RerservationRepository {
	return &rerservationRepository{
		db: db,
	}
}

func (r *rerservationRepository) GetByIDAndAfterStartDate(roomID string, start time.Time) ([]entity.Reservation, error) {
	var reservation []entity.Reservation

	tx := r.db.Where("room_id = ? AND start_date >= ?", roomID, start).First(&reservation)
	if tx.Error != nil && tx.Error != gorm.ErrRecordNotFound {
		return nil, tx.Error
	}

	return reservation, nil
}

func (r *rerservationRepository) Create(reservation entity.Reservation) (entity.Reservation, error) {
	if err := r.db.Create(&reservation).Error; err != nil {
		return entity.Reservation{}, err
	}

	return reservation, nil
}
