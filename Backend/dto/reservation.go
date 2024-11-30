package dto

import "errors"

const (
	// Failed
	MESSAGE_FAILED_GET_RESERVATION    = "failed get reservation"
	MESSAGE_FAILED_CREATE_RESERVATION = "failed create reservation"
	MESSAGE_FAILED_UPDATE_RESERVATION = "failed update reservation"
	MESSAGE_FAILED_DELETE_RESERVATION = "failed delete reservation"

	// Success
	MESSAGE_SUCCESS_GET_RESERVATION    = "success get reservation"
	MESSAGE_SUCCESS_CREATE_RESERVATION = "success create reservation"
	MESSAGE_SUCCESS_UPDATE_RESERVATION = "success update reservation"
	MESSAGE_SUCCESS_DELETE_RESERVATION = "success delete reservation"

	RESERVATION_TIME_FORMAT = "2006-01-02 15:04"
)

var (
	ErrInvalidTimeFormat           = errors.New("invalid time format")
	ErrRoomNotAvailable            = errors.New("room not available")
	ErrEndDateMustBeAfterStartDate = errors.New("end date must be after start date")
	ErrStartDateBeforeNow          = errors.New("start date must be after now")
)

type (
	ReservationAvailabilityResponse struct {
		Available bool `json:"available"`
	}

	ReservationRequest struct {
		ID        string `json:"id"`
		StartDate string `json:"start_date"`
		EndDate   string `json:"end_date"`
	}

	ReservationResponse struct {
		ID        string `json:"id"`
		RoomID    string `json:"room_id"`
		UserID    string `json:"user_id"`
		StartDate string `json:"start_date"`
		EndDate   string `json:"end_date"`
	}
)
