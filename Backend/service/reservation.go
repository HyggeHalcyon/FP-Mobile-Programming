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
		CheckAvailability(dto.CreateReservationRequest) (dto.ReservationAvailabilityResponse, error)
		MakeReservation(string, dto.CreateReservationRequest) (dto.ReservationResponse, error)
		GetMyReservations(string) ([]dto.MyReservationResponse, error)
		Update(string, dto.UpdateReservationRequest) (dto.ReservationResponse, error)
		GetDetails(string) (dto.ReservationResponse, error)
		Delete(string, string) error
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

func (s *reservationService) GetMyReservations(userID string) ([]dto.MyReservationResponse, error) {
	reserves, err := s.reservationRepo.GetByUserID(userID)
	if err != nil {
		return nil, err
	}

	var ret []dto.MyReservationResponse
	for i, r := range reserves {
		if time.Now().After(r.StartDate) && r.Status == dto.ENUM_RESERVATION_STATUS_ACCEPTED {
			reserves[i].Status = dto.ENUM_RESERVATION_STATUS_COMPLETED
		}

		// prolly more effective to get the room by joining in one query when getting the reserves but i cant be bothered atm
		room, err := s.roomRepo.GetByID(r.RoomID.String())
		if err != nil {
			return nil, err
		}

		ret = append(ret, dto.MyReservationResponse{
			ID:        reserves[i].ID.String(),
			RoomName:  room.Name,
			RoomPic:   room.Picture,
			Status:    reserves[i].Status,
			Capacity:  room.Capacity,
			StartDate: reserves[i].StartDate.Format(dto.RESERVATION_TIME_FORMAT),
			EndDate:   reserves[i].EndDate.Format(dto.RESERVATION_TIME_FORMAT),
		})
	}

	return ret, nil
}

func (s *reservationService) CheckAvailability(req dto.CreateReservationRequest) (dto.ReservationAvailabilityResponse, error) {
	startDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.StartDate)
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, dto.ErrInvalidTimeFormat
	}

	endDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.EndDate)
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, dto.ErrInvalidTimeFormat
	}

	if time.Now().After(startDate) {
		return dto.ReservationAvailabilityResponse{}, dto.ErrStartDateMustBeFuture
	}

	if endDate.Before(startDate) {
		return dto.ReservationAvailabilityResponse{}, dto.ErrEndDateMustBeAfterStartDate
	}

	// room, err := s.roomRepo.GetByID(req.ID)
	// if err != nil {
	// 	return dto.ReservationAvailabilityResponse{}, err
	// }

	// if room.StartHour > startDate.Hour() || room.EndHour < endDate.Hour() {
	// 	return dto.ReservationAvailabilityResponse{
	// 		Available: false,
	// 	}, nil
	// } else if room.StartMinute > startDate.Minute() || room.EndMinute < endDate.Minute() {
	// 	return dto.ReservationAvailabilityResponse{
	// 		Available: false,
	// 	}, nil
	// }

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

func (s *reservationService) MakeReservation(userID string, req dto.CreateReservationRequest) (dto.ReservationResponse, error) {
	startDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.StartDate)
	if err != nil {
		return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
	}

	endDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.EndDate)
	if err != nil {
		return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
	}

	reservation := entity.Reservation{
		UserID:    uuid.MustParse(userID),
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

func (s *reservationService) GetDetails(id string) (dto.ReservationResponse, error) {
	reservation, err := s.reservationRepo.GetByID(id)
	if err != nil {
		return dto.ReservationResponse{}, err
	}

	return dto.ReservationResponse{
		ID:        reservation.ID.String(),
		RoomID:    reservation.RoomID.String(),
		StartDate: reservation.StartDate.Format(dto.RESERVATION_TIME_FORMAT),
		EndDate:   reservation.EndDate.Format(dto.RESERVATION_TIME_FORMAT),
	}, nil
}

func (s *reservationService) Update(userID string, req dto.UpdateReservationRequest) (dto.ReservationResponse, error) {
	reservation, err := s.reservationRepo.GetByID(req.ID)
	if err != nil {
		return dto.ReservationResponse{}, err
	}

	if reservation.UserID.String() != userID {
		return dto.ReservationResponse{}, dto.ErrOtherUserReservation
	}

	if req.StartDate == "" && req.EndDate == "" {
		return dto.ReservationResponse{}, nil
	}

	var new entity.Reservation
	new.ID = reservation.ID

	ret := dto.ReservationResponse{
		ID:     new.ID.String(),
		RoomID: reservation.RoomID.String(),
	}

	if req.StartDate != "" {
		startDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.StartDate)
		if err != nil {
			return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
		}

		if time.Now().After(startDate) {
			return dto.ReservationResponse{}, dto.ErrStartDateMustBeFuture
		}

		new.StartDate = startDate
		ret.StartDate = startDate.Format(dto.RESERVATION_TIME_FORMAT)
	}

	if req.EndDate != "" {
		endDate, err := time.Parse(dto.RESERVATION_TIME_FORMAT, req.EndDate)
		if err != nil {
			return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
		}

		if req.StartDate == "" {
			if new.StartDate.After(endDate) {
				return dto.ReservationResponse{}, dto.ErrEndDateMustBeAfterStartDate
			}
		} else {
			if reservation.StartDate.After(endDate) {
				return dto.ReservationResponse{}, dto.ErrEndDateMustBeAfterStartDate
			}
		}

		new.EndDate = endDate
		ret.EndDate = endDate.Format(dto.RESERVATION_TIME_FORMAT)
	}

	err = s.reservationRepo.Update(new)
	if err != nil {
		return dto.ReservationResponse{}, err
	}

	return ret, nil
}

func (s *reservationService) Delete(id, userID string) error {
	reservation, err := s.reservationRepo.GetByID(id)
	if err != nil {
		return err
	}

	if reservation.UserID.String() != userID {
		return dto.ErrOtherUserReservation
	}

	if time.Now().After(reservation.StartDate) {
		return dto.ErrPastReservation
	}

	return s.reservationRepo.DeleteByID(id)
}
