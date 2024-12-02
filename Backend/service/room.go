package service

import (
	"Tekber-BE/dto"
	"Tekber-BE/repository"

	"gorm.io/gorm"
)

type (
	RoomService interface {
		GetDetailsByID(string) (dto.RoomDetailResponse, error)
		GetAll() ([]dto.RoomListResponse, error)
	}

	roomService struct {
		roomRepo     repository.RoomRepository
		facilityRepo repository.FacilityRepository
	}
)

func NewRoomService(rr repository.RoomRepository, fr repository.FacilityRepository) RoomService {
	return &roomService{
		roomRepo:     rr,
		facilityRepo: fr,
	}
}

func (s *roomService) GetDetailsByID(id string) (dto.RoomDetailResponse, error) {
	room, err := s.roomRepo.GetByID(id)
	if err != nil {
		return dto.RoomDetailResponse{}, err
	}

	facilities, err := s.facilityRepo.GetByRoomID(id)
	if err != nil {
		return dto.RoomDetailResponse{}, err
	}

	response := dto.RoomDetailResponse{
		ID:       room.ID.String(),
		Name:     room.Name,
		Capacity: room.Capacity,
		Location: room.Location,
	}

	for _, facility := range facilities {
		response.Facilities = append(response.Facilities, facility.Name)
	}

	return response, nil
}

func (s *roomService) GetAll() ([]dto.RoomListResponse, error) {
	rooms, err := s.roomRepo.GetAll()
	if err != nil {
		return nil, err
	}

	var response []dto.RoomListResponse
	for _, room := range rooms {
		facilities, err := s.facilityRepo.GetByRoomID(room.ID.String())
		if err != nil && err != gorm.ErrRecordNotFound {
			return nil, err
		}

		facility_str_arr := []string{}

		for _, facility := range facilities {
			facility_str_arr = append(facility_str_arr, facility.Name)
		}

		response = append(response, dto.RoomListResponse{
			ID:         room.ID.String(),
			Name:       room.Name,
			Capacity:   room.Capacity,
			Picture:    room.Picture,
			Facilities: facility_str_arr,
		})
	}

	return response, nil
}
