package seeder

import (
	"Tekber-BE/migrations/seeder/seeders"

	"gorm.io/gorm"
)

func RunSeeders(db *gorm.DB) error {
	if err := seeders.RoleSeeder(db); err != nil {
		return err
	}

	if err := seeders.UserSeeder(db); err != nil {
		return err
	}

	if err := seeders.RoomSeeders(db); err != nil {
		return err
	}

	if err := seeders.FacilitySeeders(db); err != nil {
		return err
	}

	return nil
}
