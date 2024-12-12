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
		GetMyReservations(*gin.Context)
		CheckAvailability(*gin.Context)
		CreateReservation(*gin.Context)
		UpdateReservation(*gin.Context)
		DeleteReservation(*gin.Context)
		GetDetails(*gin.Context)
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

func (c *reservationController) GetMyReservations(ctx *gin.Context) {
	userID := ctx.MustGet(constants.CTX_KEY_USER_ID).(string)

	result, err := c.reservationService.GetMyReservations(userID)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_GET_RESERVATION, result)
	ctx.JSON(http.StatusOK, res)
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
	userID := ctx.MustGet(constants.CTX_KEY_USER_ID).(string)

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

	result, err := c.reservationService.MakeReservation(userID, req)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_CREATE_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_CREATE_RESERVATION, result)
	ctx.JSON(http.StatusOK, res)
}

func (c *reservationController) GetDetails(ctx *gin.Context) {
	id := ctx.Param("id")

	result, err := c.reservationService.GetDetails(id)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_GET_RESERVATION, result)
	ctx.JSON(http.StatusOK, res)
}

func (c *reservationController) DeleteReservation(ctx *gin.Context) {
	id := ctx.Param("id")
	userID := ctx.MustGet(constants.CTX_KEY_USER_ID).(string)

	err := c.reservationService.Delete(id, userID)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_DELETE_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_DELETE_RESERVATION, nil)
	ctx.JSON(http.StatusOK, res)
}

func (c *reservationController) UpdateReservation(ctx *gin.Context) {
	userID := ctx.MustGet(constants.CTX_KEY_USER_ID).(string)

	var req dto.UpdateReservationRequest
	if err := ctx.ShouldBind(&req); err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_DATA_FROM_BODY, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	result, err := c.reservationService.Update(userID, req)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_UPDATE_RESERVATION, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_UPDATE_RESERVATION, result)
	ctx.JSON(http.StatusOK, res)
}
