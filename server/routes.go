package server

import (
	"net/http"

	"github.com/dhinogz/eventos-tec/assets"
	"github.com/dhinogz/eventos-tec/ui"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func (s *Server) routes() *chi.Mux {
	r := chi.NewRouter()

	// Declare middleware
	r.Use(middleware.RequestSize(300000000)) // max ~300MB body
	r.Use(middleware.Logger)
	r.Use(middleware.Compress(5, "text/html", "text/css", "application/javascript"))

	// Declare asset paths
	r.Get("/static/*", assets.AssetsHandler(s.logger, false))

	// Home page
	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		ui.Render(r.Context(), w, http.StatusOK, ui.Home())
	})

	r.Route("/events", func(r chi.Router) {
		r.Get("/", s.handleEventList)
		r.Post("/", s.handleNewEvent)
		r.Get("/new", s.handleEventForm)
		r.Route("/{eventID}", func(r chi.Router) {
			r.Get("/", s.handleEventDetails)
			// r.Post("/", s.handleNewEvent)
			r.Get("/report", s.handleEventReports)
		})
	})

	return r
}
