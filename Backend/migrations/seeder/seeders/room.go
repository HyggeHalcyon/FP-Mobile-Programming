package seeders

import (
	"Tekber-BE/entity"
	"encoding/json"
	"errors"
	"io"
	"os"

	"gorm.io/gorm"
)

func RoomSeeders(db *gorm.DB) error {
	hasTable := db.Migrator().HasTable(&entity.Room{})
	if !hasTable {
		if err := db.Migrator().CreateTable(&entity.Room{}); err != nil {
			return err
		}
	}

	jsonFile, err := os.Open("./migrations/seeder/json/room.json")
	if err != nil {
		return err
	}
	jsonData, _ := io.ReadAll(jsonFile)

	var listRooms []entity.Room
	json.Unmarshal(jsonData, &listRooms)

	// only create if it does not exist
	for _, data := range listRooms {
		var room entity.Room
		err := db.Where(&entity.Room{ID: data.ID}).First(&room).Error
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			return err
		}

		exist := db.Find(&room, "id = ?", data.ID).RowsAffected
		if exist == 0 {
			if err := db.Create(&data).Error; err != nil {
				return err
			}
		}
	}

	return nil
}
