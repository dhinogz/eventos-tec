package server

import (
	"log"
	"log/slog"
	"net/http"
	"os"

	"github.com/dhinogz/eventos-tec/assets"
	"github.com/dhinogz/eventos-tec/db"
	"github.com/dhinogz/eventos-tec/ui"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

const (
	DefaultPort = ":42069"
)

type Server struct {
	logger *slog.Logger
	port   string
	router *chi.Mux
	store  *db.Queries
}

func New(options ...func(*Server)) *Server {
	svr := &Server{}
	svr.port = DefaultPort

	for _, o := range options {
		o(svr)
	}

	return svr
}

func WithPort(port string) func(*Server) {
	if port == "" {
		port = DefaultPort
	}
	return func(s *Server) {
		s.port = port
	}
}

func WithStore(store *db.Queries) func(*Server) {
	if store == nil {
		log.Fatalf("store is nil")
	}
	return func(s *Server) {
		s.store = store
	}
}

func WithLogger(logger *slog.Logger) func(*Server) {
	if logger == nil {
		logger = slog.New(slog.NewTextHandler(os.Stdout, nil))
	}
	return func(s *Server) {
		s.logger = logger
	}
}

func (s *Server) Start() error {
	s.router = s.routes()
	s.logger.Info("starting web app", "port", s.port)
	return http.ListenAndServe(s.port, s.router)
}

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

	r.Get("/events", func(w http.ResponseWriter, r *http.Request) {
		e := []ui.Event{
			{
				Name:    "Title",
				Details: "Details",
			},
		}
		ui.Render(r.Context(), w, http.StatusOK, ui.EventListPage(e))
	})

	r.Get("/events/{eventID}/report", s.handleEventReports)

	return r
}
