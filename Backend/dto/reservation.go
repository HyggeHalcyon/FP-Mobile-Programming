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

	ENUM_RESERVATION_STATUS_ACCEPTED  = "Accepted"
	ENUM_RESERVATION_STATUS_PENDING   = "Pending"
	ENUM_RESERVATION_STATUS_REJECTED  = "Rejected"
	ENUM_RESERVATION_STATUS_COMPLETED = "Completed"
)

var (
	ErrInvalidTimeFormat           = errors.New("invalid time format")
	ErrRoomNotAvailable            = errors.New("room not available")
	ErrEndDateMustBeAfterStartDate = errors.New("end date must be after start date")
	ErrStartDateMustBeFuture       = errors.New("start date must be in the future")
	ErrOtherUserReservation        = errors.New("unable to operate on other user reservation")
	ErrPastReservation             = errors.New("unable to operate on past reservation")
)

type (
	ReservationAvailabilityResponse struct {
		Available bool `json:"available"`
	}

	CreateReservationRequest struct {
		ID        string `json:"id" binding:"required"`
		StartDate string `json:"start_date" binding:"required"`
		EndDate   string `json:"end_date" binding:"required"`
	}

	UpdateReservationRequest struct {
		ID        string `json:"id" binding:"required"`
		StartDate string `json:"start_date"`
		EndDate   string `json:"end_date"`
	}

	MyReservationResponse struct {
		ID        string `json:"id"`
		Status    string `json:"status"`
		RoomName  string `json:"room_name"`
		RoomPic   string `json:"room_pic"`
		Capacity  int    `json:"capacity"`
		StartDate string `json:"start_date,omitempty"`
		EndDate   string `json:"end_date,omitempty"`
	}

	ReservationResponse struct {
		ID        string `json:"id"`
		RoomID    string `json:"room_id"`
		UserID    string `json:"user_id,omitempty"`
		Status    string `json:"status"`
		StartDate string `json:"start_date,omitempty"`
		EndDate   string `json:"end_date,omitempty"`
	}
)
