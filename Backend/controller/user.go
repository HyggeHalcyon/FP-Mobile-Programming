package controller

import (
	"net/http"

	"Tekber-BE/config"
	"Tekber-BE/constants"
	"Tekber-BE/dto"
	"Tekber-BE/entity"
	"Tekber-BE/service"
	"Tekber-BE/utils"

	"github.com/gin-gonic/gin"
)

type (
	UserController interface {
		Login(ctx *gin.Context)
		Me(ctx *gin.Context)
	}

	userController struct {
		jwtService  config.JWTService
		userService service.UserService
	}
)

func NewUserController(us service.UserService, jwt config.JWTService) UserController {
	return &userController{
		jwtService:  jwt,
		userService: us,
	}
}

func (c *userController) Login(ctx *gin.Context) {
	var req dto.UserLoginRequest
	if err := ctx.ShouldBind(&req); err != nil {
		response := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_DATA_FROM_BODY, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, response)
		return
	}

	user, err := c.userService.VerifyLogin(ctx.Request.Context(), req.NRP, req.Password)
	if err != nil {
		response := utils.BuildResponseFailed(dto.MESSAGE_FAILED_LOGIN, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusUnauthorized, response)
		return
	}

	token := c.jwtService.GenerateToken(user.ID.String(), user.Role.Name)
	userResponse := entity.Authorization{
		Token: token,
		Role:  user.Role.Name,
	}

	response := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_LOGIN, userResponse)
	ctx.JSON(http.StatusOK, response)
}

func (c *userController) Me(ctx *gin.Context) {
	userID := ctx.MustGet(constants.CTX_KEY_USER_ID).(string)
	userRole := ctx.MustGet(constants.CTX_KEY_ROLE_NAME).(string)

	result, err := c.userService.Me(ctx.Request.Context(), userID, userRole)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_USER, err.Error(), nil)
		ctx.JSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_GET_USER, result)
	ctx.JSON(http.StatusOK, res)
}
