# ITS Rent Hub

Mobile Programming Final Project

## Database
```ps
PS D:\git\FP-Mobile-Programming> cd .\Backend\
PS D:\git\FP-Mobile-Programming\Backend> docker compose up -d
```

## Backend 
```ps
PS D:\git\FP-Mobile-Programming\Backend> cp .env.example .env
```
then make sure to setup `.env` in accordance to your local setup or you

```ps
PS D:\git\FP-Mobile-Programming> cd .\Backend\
PS D:\git\FP-Mobile-Programming\Backend> go build main.go
PS D:\git\FP-Mobile-Programming\Backend> .\main.exe
[GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.

[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:   export GIN_MODE=release
 - using code:  gin.SetMode(gin.ReleaseMode)

[GIN-debug] GET    /api/file/*filepath       --> github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1 (5 handlers)
[GIN-debug] HEAD   /api/file/*filepath       --> github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1 (5 handlers)
[GIN-debug] POST   /api/user/login           --> Tekber-BE/controller.UserController.Login-fm (4 handlers)
[GIN-debug] GET    /api/user/me              --> Tekber-BE/controller.UserController.Me-fm (5 handlers)
[GIN-debug] GET    /api/room/:id             --> Tekber-BE/controller.RoomController.GetDetail-fm (4 handlers)
[GIN-debug] GET    /api/room/                --> Tekber-BE/controller.RoomController.GetAll-fm (4 handlers)
[GIN-debug] POST   /api/reservation          --> Tekber-BE/controller.ReservationController.CreateReservation-fm (5 handlers)
[GIN-debug] GET    /api/reservation/:id      --> Tekber-BE/controller.ReservationController.GetDetails-fm (5 handlers)
[GIN-debug] PATCH  /api/reservation          --> Tekber-BE/controller.ReservationController.UpdateReservation-fm (5 handlers)
[GIN-debug] DELETE /api/reservation/:id      --> Tekber-BE/controller.ReservationController.DeleteReservation-fm (5 handlers)
[GIN-debug] [WARNING] You trusted all proxies, this is NOT safe. We recommend you to set a value.
Please check https://pkg.go.dev/github.com/gin-gonic/gin#readme-don-t-trust-all-proxies for details.
[GIN-debug] Listening and serving HTTP on :8888
```

## Flutter
```ps
PS D:\git\FP-Mobile-Programming> cd .\Flutter\
PS D:\git\FP-Mobile-Programming\Flutter> flutter run
```