package routes

import (
	"Tekber-BE/config"
	"Tekber-BE/controller"
	"Tekber-BE/middleware"

	"github.com/gin-gonic/gin"
)

func User(route *gin.Engine, userController controller.UserController, jwtService config.JWTService) {
	routes := route.Group("/api/user")
	{
		routes.POST("/login", userController.Login)
		routes.GET("/me", middleware.Authenticate(jwtService), userController.Me)
	}
}
