package main

import (
	"context"
	"fmt"
	"log"
	"log/slog"
	"os"
	"time"

	"github.com/dhinogz/eventos-tec/db"
	"github.com/dhinogz/eventos-tec/server"
	"github.com/jackc/pgx/v5"
	"github.com/joho/godotenv"
)

func main() {
	ctx := context.Background()

	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))

	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	port := os.Getenv("PORT")
	dbUrl := loadPostgres()

	conn, err := pgx.Connect(ctx, dbUrl)
	if err != nil {
		log.Fatalf("unable to connect to database: %v\n", err)
	}
	defer conn.Close(context.Background())

	ctx, cancel := context.WithTimeout(ctx, time.Duration(time.Second*2))
	if err := conn.Ping(ctx); err != nil {
		logger.Error("could not ping db", "err", err, "db", dbUrl)
	}
	defer cancel()

	q := db.New(conn)

	svr := server.New(
		server.WithLogger(logger),
		server.WithPort(port),
		server.WithStore(q),
	)

	log.Fatal(svr.Start())
}

type PostgresConfig struct {
	Host     string
	Port     string
	User     string
	Password string
	Database string
}

func loadPostgres() string {
	PostgresConfig := PostgresConfig{
		Host:     os.Getenv("PSQL_HOST"),
		Port:     os.Getenv("PSQL_PORT"),
		User:     os.Getenv("PSQL_USER"),
		Password: os.Getenv("PSQL_PASSWORD"),
		Database: os.Getenv("PSQL_DATABASE"),
	}

	postgresDbDSN := fmt.Sprintf(
		"postgres://%s:%s@%s:%s/%s?sslmode=disable",
		PostgresConfig.User,
		PostgresConfig.Password,
		PostgresConfig.Host,
		PostgresConfig.Port,
		PostgresConfig.Database,
	)

	return postgresDbDSN
}
