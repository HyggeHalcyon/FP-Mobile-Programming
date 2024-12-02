package main

import (
	"log"
	"net/http"
	"os"

	"Tekber-BE/config"
	"Tekber-BE/controller"
	"Tekber-BE/middleware"
	"Tekber-BE/migrations/seeder"
	"Tekber-BE/repository"
	"Tekber-BE/routes"
	"Tekber-BE/service"

	"github.com/gin-gonic/gin"
	_ "github.com/joho/godotenv/autoload"
	"gorm.io/gorm"
)

func main() {
	var (
		db         *gorm.DB          = config.SetUpDatabaseConnection()
		jwtService config.JWTService = config.NewJWTService()

		userRepository     repository.UserRepository         = repository.NewUserRepository(db)
		facilityRepository repository.FacilityRepository     = repository.NewFacilityRepository(db)
		roomRepository     repository.RoomRepository         = repository.NewRoomRepository(db)
		reservationRepo    repository.RerservationRepository = repository.NewReservationRepository(db)

		userService        service.UserService        = service.NewUserService(userRepository)
		roomService        service.RoomService        = service.NewRoomService(roomRepository, facilityRepository)
		reservationService service.ReservationService = service.NewReservationService(roomRepository, reservationRepo)

		userController        controller.UserController        = controller.NewUserController(userService, jwtService)
		roomController        controller.RoomController        = controller.NewRoomController(roomService)
		reservationController controller.ReservationController = controller.NewReservationController(reservationService)
	)

	server := gin.Default()
	server.Use(middleware.CORSMiddleware())
	filegroup := server.Group("/api/file")
	{
		filegroup.Use(middleware.Authenticate(jwtService))
		filegroup.StaticFS("", http.Dir("./files"))
	}

	routes.User(server, userController, jwtService)
	routes.Room(server, roomController, jwtService)
	routes.Reservation(server, reservationController, jwtService)

	if err := seeder.RunSeeders(db); err != nil {
		log.Fatalf("error migration seeder: %v", err)
		return
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8888"
	}

	if err := server.Run(":" + port); err != nil {
		log.Fatalf("error running server: %v", err)
	}
}
