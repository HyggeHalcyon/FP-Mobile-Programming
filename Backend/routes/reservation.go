package routes

import (
	"Tekber-BE/config"
	"Tekber-BE/controller"
	"Tekber-BE/middleware"

	"github.com/gin-gonic/gin"
)

func Reservation(route *gin.Engine, reservationController controller.ReservationController, jwtService config.JWTService) {
	routes := route.Group("/api/reservation")
	{
		// routes.POST("/check", middleware.Authenticate(jwtService))
		routes.POST("", middleware.Authenticate(jwtService), reservationController.CreateReservation)
		routes.GET("", middleware.Authenticate(jwtService), reservationController.GetMyReservations)
		routes.GET("/:id", middleware.Authenticate(jwtService), reservationController.GetDetails)
		routes.PATCH("", middleware.Authenticate(jwtService), reservationController.UpdateReservation)
		routes.DELETE("/:id", middleware.Authenticate(jwtService), reservationController.DeleteReservation)
	}
}
