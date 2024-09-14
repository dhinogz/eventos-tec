package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "<h1>Hello, eventos-tec!</h1>")
	})
	port := ":42069"

	srv := http.Server{
		Addr:    port,
		Handler: mux,
	}

	log.Fatal(srv.ListenAndServe())
}
