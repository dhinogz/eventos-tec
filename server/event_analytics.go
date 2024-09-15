package server

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/dhinogz/eventos-tec/db"
	"github.com/go-chi/chi/v5"
)

func (s *Server) handleEventReports(w http.ResponseWriter, r *http.Request) {
	eventID, err := strconv.ParseInt(chi.URLParam(r, "eventID"), 64, 10)
	if err != nil {
		userErr := fmt.Errorf("unlucky")
		fmt.Fprintf(w, userErr.Error())
	}

	attendance, err := s.store.QueryAttendace(r.Context(), eventID)
	if err != nil {
		userErr := fmt.Errorf("unlucky")
		fmt.Fprintf(w, userErr.Error())
	}

	reviewScore, err := s.store.QueryMeanReviews(r.Context(), eventID)
	if err != nil {
		userErr := fmt.Errorf("unlucky")
		fmt.Fprintf(w, userErr.Error())
	}

	err = s.store.InsertEventAnalytics(r.Context(), db.InsertEventAnalyticsParams{
		EventID:         eventID,
		AttendanceCount: int32(attendance),
		MeanReviews:     reviewScore,
	})
	if err != nil {
		userErr := fmt.Errorf("unlucky")
		fmt.Fprintf(w, userErr.Error())
	}

	fmt.Fprintf(w, "%d %d %f", eventID, attendance, reviewScore)

}

func (s *Server) handleEventData(w http.ResponseWriter, r *http.Request) {
	events, err := s.store.GetEventsReport(r.Context())
	if err != nil {
		s.logger.Error("failed to get events report", "err", err)
		http.Error(w, "could not retrieve events", http.StatusInternalServerError)
		return
	}

	// Convert the events to JSON
	w.Header().Set("Content-Type", "application/json")
	err = json.NewEncoder(w).Encode(events)
	if err != nil {
		s.logger.Error("failed to encode events to json", "err", err)
		http.Error(w, "could not encode events", http.StatusInternalServerError)
	}
}
