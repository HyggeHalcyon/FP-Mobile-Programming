package repository

import (
	"Tekber-BE/entity"
	"time"

	"gorm.io/gorm"
)

type (
	RerservationRepository interface {
		GetByID(string) (entity.Reservation, error)
		GetByUserID(string) ([]entity.Reservation, error)
		FindOverlapping(string, time.Time, time.Time) (bool, error)
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

func (r *reservationRepository) GetByUserID(userID string) ([]entity.Reservation, error) {
	var reservation []entity.Reservation

	if err := r.db.Where("user_id = ?", userID).Find(&reservation).Error; err != nil {
		return nil, err
	}

	return reservation, nil
}

func (r *reservationRepository) FindOverlapping(roomID string, start time.Time, end time.Time) (bool, error) {
	var reservation entity.Reservation

	tx := r.db.Where("room_id = ? AND (start_date <= ? AND end_date >= ?)", roomID, start, end).First(&reservation)
	if tx.Error != nil && tx.Error != gorm.ErrRecordNotFound {
		return false, tx.Error
	}
	if tx.RowsAffected != 0 {
		return false, nil
	}

	tx = r.db.Where("room_id = ? AND (start_date >= ? AND end_date <= ?)", roomID, start, end).First(&reservation)
	if tx.Error != nil && tx.Error != gorm.ErrRecordNotFound {
		return false, tx.Error
	}
	if tx.RowsAffected != 0 {
		return false, nil
	}

	tx = r.db.Where("room_id = ? AND (start_date >= ? AND start_date <= ?)", roomID, start, end).First(&reservation)
	if tx.Error != nil && tx.Error != gorm.ErrRecordNotFound {
		return false, tx.Error
	}
	if tx.RowsAffected != 0 {
		return false, nil
	}

	tx = r.db.Where("room_id = ? AND (end_date >= ? AND end_date <= ?)", roomID, start, end).First(&reservation)
	if tx.Error != nil && tx.Error != gorm.ErrRecordNotFound {
		return false, tx.Error
	}
	if tx.RowsAffected != 0 {
		return false, nil
	}

	return true, nil
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
