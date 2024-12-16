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
		GetMyReservations(string) ([]dto.MyReservationResponse, error)
		Update(string, dto.UpdateReservationRequest) (dto.ReservationResponse, error)
		GetDetails(string) (dto.ReservationResponse, error)
		Delete(string, string) error
	}

	reservationService struct {
		reservationRepo repository.RerservationRepository
		facilityRepo    repository.FacilityRepository
		roomRepo        repository.RoomRepository
	}
)

func NewReservationService(rr1 repository.RoomRepository, rr2 repository.RerservationRepository, fr repository.FacilityRepository) ReservationService {
	return &reservationService{
		reservationRepo: rr2,
		facilityRepo:    fr,
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

func (s *reservationService) CheckAvailability(req dto.ReservationRequest) (dto.ReservationAvailabilityResponse, error) {
	startDate, err := time.ParseInLocation(dto.RESERVATION_TIME_FORMAT, req.StartDate, time.Now().UTC().Location())
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, dto.ErrInvalidTimeFormat
	}

	endDate, err := time.ParseInLocation(dto.RESERVATION_TIME_FORMAT, req.EndDate, time.Now().UTC().Location())
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, dto.ErrInvalidTimeFormat
	}

	if time.Now().After(startDate) {
		return dto.ReservationAvailabilityResponse{}, dto.ErrStartDateMustBeFuture
	}

	if endDate.Before(startDate) {
		return dto.ReservationAvailabilityResponse{}, dto.ErrEndDateMustBeAfterStartDate
	}

	room, err := s.roomRepo.GetByID(req.ID)
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, err
	}

	res, err := s.reservationRepo.FindOverlapping(room.ID.String(), startDate, endDate)
	if err != nil {
		return dto.ReservationAvailabilityResponse{}, err
	}

	return dto.ReservationAvailabilityResponse{
		Available: res,
	}, nil
}

func (s *reservationService) MakeReservation(userID string, req dto.ReservationRequest) (dto.ReservationResponse, error) {
	startDate, err := time.ParseInLocation(dto.RESERVATION_TIME_FORMAT, req.StartDate, time.Now().UTC().Location())
	if err != nil {
		return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
	}

	endDate, err := time.ParseInLocation(dto.RESERVATION_TIME_FORMAT, req.EndDate, time.Now().UTC().Location())
	if err != nil {
		return dto.ReservationResponse{}, dto.ErrInvalidTimeFormat
	}

	reservation := entity.Reservation{
		UserID:    uuid.MustParse(userID),
		RoomID:    uuid.MustParse(req.ID),
		Status:    dto.ENUM_RESERVATION_STATUS_PENDING,
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

	room, err := s.roomRepo.GetByID(reservation.RoomID.String())
	if err != nil {
		return dto.ReservationResponse{}, err
	}

	facilities, err := s.facilityRepo.GetByRoomID(reservation.RoomID.String())
	if err != nil {
		return dto.ReservationResponse{}, err
	}

	ret := dto.ReservationResponse{
		ID:        reservation.ID.String(),
		RoomID:    reservation.RoomID.String(),
		Location:  room.Location,
		Capacity:  room.Capacity,
		RoomName:  room.Name,
		StartDate: reservation.StartDate.Format(dto.RESERVATION_TIME_FORMAT),
		EndDate:   reservation.EndDate.Format(dto.RESERVATION_TIME_FORMAT),
	}

	for _, fac := range facilities {
		ret.Facilities = append(ret.Facilities, fac.Name)
	}

	return ret, nil
}

func (s *reservationService) Update(userID string, req dto.UpdateReservationRequest) (dto.ReservationResponse, error) {
	reservation, err := s.reservationRepo.GetByID(req.ID)
	if err != nil {
		return dto.ReservationResponse{}, err
	}

	if reservation.UserID.String() != userID {
		return dto.ReservationResponse{}, dto.ErrOtherUserReservation
	}

	if reservation.Status != dto.ENUM_RESERVATION_STATUS_PENDING {
		return dto.ReservationResponse{}, dto.ErrReservationProcessed
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
		startDate, err := time.ParseInLocation(dto.RESERVATION_TIME_FORMAT, req.StartDate, time.Now().UTC().Location())
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
		endDate, err := time.ParseInLocation(dto.RESERVATION_TIME_FORMAT, req.EndDate, time.Now().UTC().Location())
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

	if reservation.Status != dto.ENUM_RESERVATION_STATUS_PENDING {
		return dto.ErrReservationProcessed
	}

	return s.reservationRepo.DeleteByID(id)
}
