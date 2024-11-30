package seeders

import (
	"Tekber-BE/entity"
	"encoding/json"
	"errors"
	"io"
	"os"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

func FacilitySeeders(db *gorm.DB) error {
	hasTable := db.Migrator().HasTable(&entity.Facility{})
	if !hasTable {
		if err := db.Migrator().CreateTable(&entity.Facility{}); err != nil {
			return err
		}
	}

	jsonFile, err := os.Open("./migrations/seeder/json/facility.json")
	if err != nil {
		return err
	}
	jsonData, _ := io.ReadAll(jsonFile)

	var listFacilities []entity.Facility
	json.Unmarshal(jsonData, &listFacilities)

	// only create if it does not exist
	for _, data := range listFacilities {
		var facility entity.Facility
		err := db.Where(&entity.Facility{
			Name:   data.Name,
			RoomID: data.RoomID,
		}).First(&facility).Error
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			return err
		}

		exist := db.Find(&facility, "name = ? AND room_id = ?", data.Name, data.RoomID).RowsAffected
		if exist == 0 {
			data.ID = uuid.New()
			if err := db.Create(&data).Error; err != nil {
				return err
			}
		}
	}

	return nil
}
