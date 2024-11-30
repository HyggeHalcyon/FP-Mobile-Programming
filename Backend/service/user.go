package service

import (
	"context"

	"Tekber-BE/dto"
	"Tekber-BE/entity"
	"Tekber-BE/repository"
	"Tekber-BE/utils"
)

type (
	UserService interface {
		VerifyLogin(ctx context.Context, nrp string, password string) (entity.User, error)
		Me(ctx context.Context, userID string, userRole string) (dto.UserResponse, error)
	}

	userService struct {
		userRepo repository.UserRepository
	}
)

func NewUserService(ur repository.UserRepository) UserService {
	return &userService{
		userRepo: ur,
	}
}

func (s *userService) VerifyLogin(ctx context.Context, email string, password string) (entity.User, error) {
	user, err := s.userRepo.GetUserByNRP(email)
	if err != nil {
		return entity.User{}, dto.ErrCredentialsNotMatched
	}

	checkPassword, err := utils.CheckPassword(user.Password, []byte(password))
	if err != nil || !checkPassword {
		return entity.User{}, dto.ErrCredentialsNotMatched
	}

	return user, nil
}

func (s *userService) Me(ctx context.Context, userID string, userRole string) (dto.UserResponse, error) {
	user, err := s.userRepo.GetUserById(userID)
	if err != nil {
		return dto.UserResponse{}, dto.ErrGetUserById
	}

	return dto.UserResponse{
		ID:   user.ID.String(),
		Name: user.Name,
		Role: userRole,
		NRP:  user.NRP,
	}, nil
}
