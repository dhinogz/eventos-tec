package server

import (
	"fmt"
	"net/http"

	"github.com/dhinogz/eventos-tec/ui"
)

func (s *Server) handleEventList(w http.ResponseWriter, r *http.Request) {
	events, err := s.store.GetAllEvents(r.Context())
	fmt.Printf("%+v", events)

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

func (s *Server) handleEventDetails(w http.ResponseWriter, r *http.Request) {
	// event := ui.Event{
	// 	ID:             3,
	// 	OrganizationID: 103,
	// 	Title:          "Marketing Summit 2024",
	// 	Description:    "A summit bringing together top marketing experts to share insights and strategies.",
	// 	Capacity:       "300",
	// 	Date:           "2024-11-05T10:00:00Z",
	// 	Duration:       240,
	// 	Venue:          "Grand Hotel, City Center",
	// 	IsOnline:       false,
	// 	MeetingLink:    "",
	// }
	// err := ui.Render(r.Context(), w, http.StatusOK, ui.EventDetailPage(event))
	// if err != nil {
	// 	s.logger.Error("event list render", "err", err)
	// 	fmt.Fprint(w, "could not render")
	// }
}
