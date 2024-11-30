package repository

import (
	"Tekber-BE/entity"

	"gorm.io/gorm"
)

type (
	UserRepository interface {
		GetUserById(string) (entity.User, error)
		GetUserByNRP(string) (entity.User, error)
	}

	userRepository struct {
		db *gorm.DB
	}
)

func NewUserRepository(db *gorm.DB) UserRepository {
	return &userRepository{
		db: db,
	}
}

func (r *userRepository) GetUserById(userId string) (entity.User, error) {
	var user entity.User
	if err := r.db.Where("id = ?", userId).Take(&user).Error; err != nil {
		return entity.User{}, err
	}
	return user, nil
}

func (r *userRepository) GetUserByNRP(nrp string) (entity.User, error) {
	var user entity.User
	if err := r.db.Where("nrp = ?", nrp).Take(&user).Error; err != nil {
		return entity.User{}, err
	}

	var role entity.Role
	if err := r.db.Where("id = ?", user.RoleID).Take(&role).Error; err != nil {
		return entity.User{}, err
	}

	user.Role = &role

	return user, nil
}
