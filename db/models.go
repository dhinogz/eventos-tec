// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0

package db

import (
	"github.com/jackc/pgx/v5/pgtype"
)

type Category struct {
	ID        int64
	Name      string
	CreatedAt pgtype.Timestamptz
	Active    bool
}

type Event struct {
	ID             int64
	OrganizationID int64
	Title          string
	Description    string
	Capacity       int64
	Date           pgtype.Timestamp
	Duration       int64
	Venue          string
	IsOnline       bool
	MeetingLink    string
	CreatedAt      pgtype.Timestamptz
	Active         bool
}

type EventCategory struct {
	ID         int64
	CategoryID int64
	EventID    int64
	CreatedAt  pgtype.Timestamptz
	Active     bool
}

type EventRegister struct {
	ID        int64
	UserID    int64
	EventID   int64
	DidAttend bool
	CreatedAt pgtype.Timestamptz
	Active    bool
}

type EventReport struct {
	EventID         int64
	AttendanceCount int32
	MeanReviews     float64
	CreatedAt       pgtype.Timestamptz
	Active          bool
}

type Favorite struct {
	ID        int64
	UserID    int64
	EventID   int64
	CreatedAt pgtype.Timestamptz
	Active    bool
}

type Interest struct {
	ID         int64
	UserID     int64
	CategoryID int64
	CreatedAt  pgtype.Timestamptz
	Active     bool
}

type Organization struct {
	ID          int64
	Name        string
	Description string
	CreatedAt   pgtype.Timestamptz
	Active      bool
}

type OrganizationUser struct {
	ID             int64
	UserID         int64
	OrganizationID int64
	Roles          string
	CreatedAt      pgtype.Timestamptz
	Active         bool
}

type Review struct {
	ID        int64
	AuthorID  int64
	EventID   int64
	Rating    int64
	Comment   string
	CreatedAt pgtype.Timestamptz
	Active    bool
}

type Session struct {
	ID        int64
	TokenHash string
	UserID    int64
	CreatedAt pgtype.Timestamptz
	Active    bool
}

type User struct {
	ID             int64
	Email          string
	HashedPassword string
	LastLogin      pgtype.Timestamp
	CreatedAt      pgtype.Timestamptz
	Active         bool
}
