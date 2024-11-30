package controller

import (
	"Tekber-BE/constants"
	"Tekber-BE/dto"
	"Tekber-BE/service"
	"Tekber-BE/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type (
	ReservationController interface {
		CheckAvailability(*gin.Context)
		CreateReservation(*gin.Context)
	}

	reservationController struct {
		reservationService service.ReservationService
	}
)

func NewReservationController(rs service.ReservationService) ReservationController {
	return &reservationController{
		reservationService: rs,
	}
}

func (c *reservationController) CheckAvailability(ctx *gin.Context) {
	var req dto.ReservationRequest
	if err := ctx.ShouldBind(&req); err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_DATA_FROM_BODY, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	result, err := c.reservationService.CheckAvailability(req)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_GET_RESERVATION, result)
	ctx.JSON(http.StatusOK, res)
}

func (c *reservationController) CreateReservation(ctx *gin.Context) {
	userId := ctx.MustGet(constants.CTX_KEY_USER_ID).(string)

	var req dto.ReservationRequest
	if err := ctx.ShouldBind(&req); err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_DATA_FROM_BODY, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	status, err := c.reservationService.CheckAvailability(req)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_CREATE_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	if !status.Available {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_CREATE_RESERVATION, dto.ErrRoomNotAvailable.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	result, err := c.reservationService.MakeReservation(userId, req)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_CREATE_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_CREATE_RESERVATION, result)
	ctx.JSON(http.StatusOK, res)
}
