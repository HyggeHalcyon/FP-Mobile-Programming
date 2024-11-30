package dto

const (
	// Failed
	MESSAGE_FAILED_GET_ROOM = "failed get room"

	// Success
	MESSAGE_SUCCESS_GET_ROOM = "success get room"
)

type (
	RoomResponse struct {
		ID          string `json:"id"`
		Name        string `json:"name"`
		Capacity    int    `json:"capacity"`
		Availbility string `json:"availbility"`
	}

	RoomDetailResponse struct {
		ID         string   `json:"id"`
		Name       string   `json:"name"`
		Capacity   int      `json:"capacity"`
		Facilities []string `json:"facilities"`
	}
)
