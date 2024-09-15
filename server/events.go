package server

import (
	"fmt"
	"log/slog"
	"net/http"
	"strconv"
	"time"

	"github.com/dhinogz/eventos-tec/db"
	"github.com/dhinogz/eventos-tec/ui"
	"github.com/go-chi/chi/v5"
	"github.com/jackc/pgx/v5/pgtype"
)

func (s *Server) handleEventList(w http.ResponseWriter, r *http.Request) {
	events, err := s.store.GetAllEvents(r.Context())

	err = ui.Render(r.Context(), w, http.StatusOK, ui.EventListPage(events))
	if err != nil {
		s.logger.Error("event list render", "err", err)
		fmt.Fprint(w, "could not render")
	}
}

func (s *Server) handleEventForm(w http.ResponseWriter, r *http.Request) {
	err := ui.Render(r.Context(), w, http.StatusOK, ui.EventFormPage())
	if err != nil {
		s.logger.Error("event form render", "err", err)
		fmt.Fprint(w, "could not render")
	}
}

func (s *Server) handleNewEvent(w http.ResponseWriter, r *http.Request) {
	// Parse the form data
	err := r.ParseForm()
	if err != nil {
		http.Error(w, "Failed to parse form data", http.StatusBadRequest)
		return
	}

	// Extract and validate form fields
	organizationID := int64(1)

	capacity, err := strconv.ParseInt(r.FormValue("capacity"), 10, 64)
	if err != nil {
		http.Error(w, "Invalid capacity", http.StatusBadRequest)
		return
	}

	date, err := time.Parse("2006-01-02T15:04", r.FormValue("date"))
	if err != nil {
		http.Error(w, "Invalid date format", http.StatusBadRequest)
		return
	}

	duration, err := strconv.ParseInt(r.FormValue("duration"), 10, 64)
	if err != nil {
		http.Error(w, "Invalid duration", http.StatusBadRequest)
		return
	}

	isOnline := r.FormValue("is_online") == "on"

	// Create the InsertEventParams struct
	params := db.InsertEventParams{
		OrganizationID: organizationID,
		Title:          r.FormValue("title"),
		Description:    r.FormValue("description"),
		Capacity:       capacity,
		Date: pgtype.Timestamp{
			Time:  date,
			Valid: true,
		},
		Duration:    duration,
		Venue:       r.FormValue("venue"),
		IsOnline:    isOnline,
		MeetingLink: r.FormValue("meeting_link"),
	}

	// Insert the event
	err = s.store.InsertEvent(r.Context(), params)
	if err != nil {
		http.Error(w, "Failed to insert event", http.StatusInternalServerError)
		return
	}

	// Respond with success
	w.WriteHeader(http.StatusCreated)
	w.Write([]byte("Event created successfully"))

}

func (s *Server) handleEventDetails(w http.ResponseWriter, r *http.Request) {
	eventID, err := strconv.ParseInt(chi.URLParam(r, "eventID"), 10, 64)
	if err != nil {
		slog.Error("parsing event id", "err", err)
		return
	}

	event, err := s.store.GetEventDetails(r.Context(), eventID)

	err = ui.Render(r.Context(), w, http.StatusOK, ui.EventDetailPage(event))
	if err != nil {
		s.logger.Error("event list render", "err", err)
		fmt.Fprint(w, "could not render")
		return
	}
}
