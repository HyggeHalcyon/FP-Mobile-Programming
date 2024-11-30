package repository

import (
	"Tekber-BE/entity"
	"time"

	"gorm.io/gorm"
)

type (
	RerservationRepository interface {
		GetByID(string) (entity.Reservation, error)
		GetByIDAndAfterStartDate(string, time.Time) ([]entity.Reservation, error)
		Create(entity.Reservation) (entity.Reservation, error)
		Update(entity.Reservation) error
		DeleteByID(string) error
	}

	reservationRepository struct {
		db *gorm.DB
	}
)

func NewReservationRepository(db *gorm.DB) RerservationRepository {
	return &reservationRepository{
		db: db,
	}
}

func (r *reservationRepository) GetByIDAndAfterStartDate(roomID string, start time.Time) ([]entity.Reservation, error) {
	var reservation []entity.Reservation

	tx := r.db.Where("room_id = ? AND start_date >= ?", roomID, start).First(&reservation)
	if tx.Error != nil && tx.Error != gorm.ErrRecordNotFound {
		return nil, tx.Error
	}

	return reservation, nil
}

func (r *reservationRepository) Create(reservation entity.Reservation) (entity.Reservation, error) {
	if err := r.db.Create(&reservation).Error; err != nil {
		return entity.Reservation{}, err
	}

	return reservation, nil
}

func (r *reservationRepository) GetByID(id string) (entity.Reservation, error) {
	var reservation entity.Reservation

	if err := r.db.Where("id = ?", id).First(&reservation).Error; err != nil {
		return entity.Reservation{}, err
	}

	return reservation, nil
}

func (r *reservationRepository) Update(reservation entity.Reservation) error {
	if err := r.db.Updates(&reservation).Error; err != nil {
		return err
	}

	return nil
}

func (r *reservationRepository) DeleteByID(id string) error {
	if err := r.db.Where("id = ?", id).Delete(&entity.Reservation{}).Error; err != nil {
		return err
	}

	return nil
}
