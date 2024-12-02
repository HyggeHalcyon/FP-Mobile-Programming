package seeders

import (
	"Tekber-BE/entity"
	"encoding/json"
	"errors"
	"io"
	"os"

	"gorm.io/gorm"
)

func ReservationSeeders(db *gorm.DB) error {
	hasTable := db.Migrator().HasTable(&entity.Reservation{})
	if !hasTable {
		if err := db.Migrator().CreateTable(&entity.Reservation{}); err != nil {
			return err
		}
	}

	jsonFile, err := os.Open("./migrations/seeder/json/reservation.json")
	if err != nil {
		return err
	}
	jsonData, _ := io.ReadAll(jsonFile)

	var listReservations []entity.Reservation
	json.Unmarshal(jsonData, &listReservations)

	// only create if it does not exist
	for _, data := range listReservations {
		var reserv entity.Reservation
		err := db.Where(&entity.Reservation{ID: data.ID}).First(&reserv).Error
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			return err
		}

		exist := db.Find(&reserv, "id = ?", data.ID.String()).RowsAffected
		if exist == 0 {
			if err := db.Create(&data).Error; err != nil {
				return err
			}
		}
	}

	return nil
}
