package main

import (
	"log"
	"log/slog"
	"os"

	"github.com/dhinogz/eventos-tec/server"
	"github.com/joho/godotenv"
)

func main() {
	// ctx := context.Background()

	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))

	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	port := os.Getenv("PORT")
	// dbUrl := os.Getenv("EVENTS_DB_URL")

	// conn, err := pgx.Connect(ctx, dbUrl)
	// if err != nil {
	// 	log.Fatalf("unable to connect to database: %v\n", err)
	// }
	// defer conn.Close(context.Background())
	//
	// ctx, cancel := context.WithTimeout(ctx, time.Duration(time.Second*2))
	// if err := conn.Ping(ctx); err != nil {
	// 	logger.Error("could not ping db", "err", err, "db", dbUrl)
	// }
	// defer cancel()
	//
	// q := db.New(conn)

	svr := server.New(
		server.WithLogger(logger),
		server.WithPort(port),
		// server.WithStore(q),
	)

	log.Fatal(svr.Start())
}
