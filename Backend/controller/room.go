package controller

import (
	"Tekber-BE/dto"
	"Tekber-BE/service"
	"Tekber-BE/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type (
	RoomController interface {
		GetDetail(*gin.Context)
		GetAll(*gin.Context)
	}

	roomController struct {
		roomService service.RoomService
	}
)

func NewRoomController(rs service.RoomService) RoomController {
	return &roomController{
		roomService: rs,
	}
}

func (c *roomController) GetDetail(ctx *gin.Context) {
	userID := ctx.Param("id")

	result, err := c.roomService.GetDetailsByID(userID)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_ROOM, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_GET_ROOM, result)
	ctx.JSON(http.StatusOK, res)
}

func (c *roomController) GetAll(ctx *gin.Context) {
	result, err := c.roomService.GetAll()
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_ROOM, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_GET_ROOM, result)
	ctx.JSON(http.StatusOK, res)
}
