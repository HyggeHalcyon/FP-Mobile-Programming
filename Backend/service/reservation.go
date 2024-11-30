package service

import (
	"Tekber-BE/dto"
	"Tekber-BE/entity"
	"Tekber-BE/repository"
	"time"

	"github.com/google/uuid"
)

type (
	ReservationService interface {
		CheckAvailability(dto.ReservationRequest) (dto.ReservationAvailabilityResponse, error)
		MakeReservation(string, dto.ReservationRequest) (dto.ReservationResponse, error)
	}

	reservationService struct {
		reservationRepo repository.RerservationRepository
		roomRepo        repository.RoomRepository
	}
)

func NewReservationService(rr1 repository.RoomRepository, rr2 repository.RerservationRepository) ReservationService {
	return &reservationService{
		reservationRepo: rr2,
		roomRepo:        rr1,
	}
}

func (s *reservationService) CheckAvailability(req dto.ReservationRequest) (dto.ReservationAvailabilityResponse, error) {
	startDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.StartDate)
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, dto.ErrInvalidTimeFormat
	}

	endDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.EndDate)
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, dto.ErrInvalidTimeFormat
	}

	if time.Now().After(startDate) {
		return dto.ReservationAvailabilityResponse{}, dto.ErrStartDateBeforeNow
	}

	if endDate.Before(startDate) {
		return dto.ReservationAvailabilityResponse{}, dto.ErrEndDateMustBeAfterStartDate
	}

	room, err := s.roomRepo.GetByID(req.ID)
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, err
	}

	if room.StartHour > startDate.Hour() || room.EndHour < endDate.Hour() {
		return dto.ReservationAvailabilityResponse{
			Available: false,
		}, nil
	} else if room.StartMinute > startDate.Minute() || room.EndMinute < endDate.Minute() {
		return dto.ReservationAvailabilityResponse{
			Available: false,
		}, nil
	}

	// TODO
	// reservations, err := s.reservationRepo.GetByIDAndAfterStartDate(req.ID, startDate)
	// if err != nil {
	// 	return dto.ReservationAvailabilityResponse{}, err
	// }

	// for _, reservation := range reservations {
	// 	if
	// }

	return dto.ReservationAvailabilityResponse{
		Available: true,
	}, nil
}

func (s *reservationService) MakeReservation(userId string, req dto.ReservationRequest) (dto.ReservationResponse, error) {
	startDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.StartDate)
	if err != nil {
		return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
	}

	endDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.EndDate)
	if err != nil {
		return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
	}

	reservation := entity.Reservation{
		UserID:    uuid.MustParse(userId),
		RoomID:    uuid.MustParse(req.ID),
		StartDate: startDate,
		EndDate:   endDate,
	}

	reservation, err = s.reservationRepo.Create(reservation)
	if err != nil {
		return dto.ReservationResponse{}, err
	}

	return dto.ReservationResponse{
		ID:        reservation.ID.String(),
		UserID:    reservation.UserID.String(),
		RoomID:    reservation.RoomID.String(),
		StartDate: reservation.StartDate.Format(dto.RESERVATION_TIME_FORMAT),
		EndDate:   reservation.EndDate.Format(dto.RESERVATION_TIME_FORMAT),
	}, nil
}
