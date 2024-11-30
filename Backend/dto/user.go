package dto

import (
	"errors"
)

const (
	// Failed
	MESSAGE_FAILED_GET_USER = "failed get user"
	MESSAGE_FAILED_LOGIN    = "failed login"

	// Success
	MESSAGE_SUCCESS_GET_USER = "success get user"
	MESSAGE_SUCCESS_LOGIN    = "success login"
)

var (
	ErrRoleNotAllowed        = errors.New("denied access for \"%v\" role")
	ErrGetUserById           = errors.New("failed to get user by id")
	ErrCredentialsNotMatched = errors.New("credentials not matched")
)

type (
	UserLoginRequest struct {
		NRP      string `json:"nrp" form:"nrp" binding:"required"`
		Password string `json:"password" form:"password" binding:"required"`
	}

	UserResponse struct {
		ID     string `json:"id"`
		Name   string `json:"name"`
		NRP    string `json:"nrp"`
		RoleID string `json:"role_id,omitempty"`
		Role   string `json:"role,omitempty"`
	}
)
