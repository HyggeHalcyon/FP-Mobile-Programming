package entity

import (
	"Tekber-BE/utils"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type User struct {
	ID             uuid.UUID `json:"id" form:"id" gorm:"type:uuid;primary_key;default:uuid_generate_v4()" `
	RoleID         string    `json:"role_id" form:"role_id" gorm:"foreignKey" `
	Name           string    `json:"name" form:"name"`
	NRP            string    `json:"nrp" form:"nrp"`
	Password       string    `json:"password" form:"password"`
	ProfilePicture string    `json:"profile_picture" form:"profile_picture"`

	Role *Role `json:"role,omitempty" gorm:"constraint:OnUpdate:CASCADE,OnDelete:SET NULL;" `

	Timestamp
}

func (u *User) BeforeCreate(tx *gorm.DB) error {
	var err error
	u.Password, err = utils.HashPassword(u.Password)
	if err != nil {
		return err
	}
	return nil
}
