package routes

import (
	"Tekber-BE/config"
	"Tekber-BE/controller"
	"Tekber-BE/middleware"

	"github.com/gin-gonic/gin"
)

func Room(route *gin.Engine, roomController controller.RoomController, jwtService config.JWTService) {
	routes := route.Group("/api/room")
	{
		routes.GET("/:id", middleware.Authenticate(jwtService), roomController.GetDetail)
		routes.GET("/", middleware.Authenticate(jwtService), roomController.GetAll)
	}
}
