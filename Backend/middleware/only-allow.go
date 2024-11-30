package middleware

import (
	"fmt"
	"net/http"

	"Tekber-BE/constants"
	"Tekber-BE/dto"
	"Tekber-BE/utils"

	"github.com/gin-gonic/gin"
)

func OnlyAllow(roles ...string) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		userRole := ctx.GetString(constants.CTX_KEY_ROLE_NAME)

		for _, role := range roles {
			if userRole == role {
				ctx.Next()
				return
			}
		}

		err := fmt.Sprintf(dto.ErrRoleNotAllowed.Error(), userRole)
		response := utils.BuildResponseFailed(dto.MESSAGE_FAILED_VERIFY_TOKEN, err, nil)
		ctx.AbortWithStatusJSON(http.StatusUnauthorized, response)
		return
	}
}
