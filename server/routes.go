package server

import (
	"github.com/dhinogz/eventos-tec/assets"
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
	r.Get("/", s.handleEventList)

	r.Route("/events", func(r chi.Router) {
		r.Post("/", s.handleNewEvent)
		r.Get("/new", s.handleEventForm)
		r.Route("/{eventID}", func(r chi.Router) {
			r.Get("/", s.handleEventDetails)
			// r.Post("/", s.handleNewEvent)
			r.Get("/report", s.handleEventReports)
		})
		r.Get("/data", s.handleEventData)
	})

	return r
}
