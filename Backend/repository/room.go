package repository

import (
	"Tekber-BE/entity"

	"gorm.io/gorm"
)

type (
	RoomRepository interface {
		GetByID(string) (entity.Room, error)
		GetAll() ([]entity.Room, error)
	}

	roomRepository struct {
		db *gorm.DB
	}
)

func NewRoomRepository(db *gorm.DB) RoomRepository {
	return &roomRepository{
		db: db,
	}
}

func (r *roomRepository) GetByID(id string) (entity.Room, error) {
	var room entity.Room
	err := r.db.Where("id = ?", id).First(&room).Error
	if err != nil {
		return room, err
	}

	return room, nil
}

func (r *roomRepository) GetAll() ([]entity.Room, error) {
	var rooms []entity.Room
	err := r.db.Find(&rooms).Error
	if err != nil {
		return rooms, err
	}

	return rooms, nil
}
