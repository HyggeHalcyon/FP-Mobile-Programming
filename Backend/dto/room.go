package dto

const (
	// Failed
	MESSAGE_FAILED_GET_ROOM = "failed get room"

	// Success
	MESSAGE_SUCCESS_GET_ROOM = "success get room"
)

type (
	RoomListResponse struct {
		ID         string   `json:"id"`
		Name       string   `json:"name"`
		Capacity   int      `json:"capacity"`
		Picture    string   `json:"picture"`
		Facilities []string `json:"facilities"`
	}

	RoomDetailResponse struct {
		ID         string   `json:"id"`
		Name       string   `json:"name"`
		Capacity   int      `json:"capacity"`
		Location   string   `json:"location"`
		Facilities []string `json:"facilities"`
	}
)
