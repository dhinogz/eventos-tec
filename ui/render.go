package ui

import (
	"context"
	"net/http"

	"github.com/a-h/templ"
)

var (
	HeaderContentType = "Content-Type"
	MIMETextHTML      = "text/html"
)

// Render renders a templ component with the appropriate headers.
func Render(ctx context.Context, w http.ResponseWriter, code int, c templ.Component) error {
	w.WriteHeader(code)
	w.Header().Add(HeaderContentType, MIMETextHTML)
	return c.Render(ctx, w)
}
