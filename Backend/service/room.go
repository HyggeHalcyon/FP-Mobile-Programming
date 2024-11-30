package service

import (
	"Tekber-BE/dto"
	"Tekber-BE/repository"
	"fmt"
)

type (
	RoomService interface {
		GetDetailsByID(string) (dto.RoomDetailResponse, error)
		GetAll() ([]dto.RoomResponse, error)
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
	}

	for _, facility := range facilities {
		response.Facilities = append(response.Facilities, facility.Name)
	}

	return response, nil
}

func (s *roomService) GetAll() ([]dto.RoomResponse, error) {
	rooms, err := s.roomRepo.GetAll()
	if err != nil {
		return nil, err
	}

	var response []dto.RoomResponse
	for _, room := range rooms {
		response = append(response, dto.RoomResponse{
			ID:          room.ID.String(),
			Name:        room.Name,
			Capacity:    room.Capacity,
			Availbility: fmt.Sprintf("%02d:%02d - %02d:%02d", room.StartHour, room.StartMinute, room.EndHour, room.EndMinute),
		})
	}

	return response, nil
}
