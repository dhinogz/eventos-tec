package assets

import (
	"embed"
	"io/fs"
	"log/slog"
	"net/http"
	"os"
)

//go:embed all:dist
var assets embed.FS

func disableCacheInLiveMode(live bool, next http.Handler) http.Handler {
	if !live {
		return next
	}
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Cache-Control", "no-store")
		next.ServeHTTP(w, r)
	})
}

func AssetsHandler(logger *slog.Logger, live bool) http.HandlerFunc {
	assetHandler := http.StripPrefix("/static", http.FileServer(GetFileSystem(logger, live)))
	return disableCacheInLiveMode(live, assetHandler).ServeHTTP
}

func GetFileSystem(logger *slog.Logger, live bool) http.FileSystem {
	l := logger.With("system", "assets")
	if live {
		l.Info("using live mode")
		return http.FS(os.DirFS("assets/dist"))
	}

	l.Info("using embedded mode")
	fsys, err := fs.Sub(assets, "dist")
	if err != nil {
		panic(err)
	}

	return http.FS(fsys)
}
