package routes

import (
	"Tekber-BE/config"
	"Tekber-BE/controller"

	"github.com/gin-gonic/gin"
)

func Room(route *gin.Engine, roomController controller.RoomController, jwtService config.JWTService) {
	routes := route.Group("/api/room")
	{
		routes.GET("/:id", roomController.GetDetail)
		routes.GET("/", roomController.GetAll)
	}
}
