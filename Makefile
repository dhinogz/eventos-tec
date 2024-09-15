include .env

PSQL_DSN = "postgres://${PSQL_USER}:${PSQL_PASSWORD}@${PSQL_HOST}:${PSQL_PORT}/${PSQL_DATABASE}?sslmode=${PSQL_SSLMODE}"

templ-gen:
	templ generate

build:
	go build -o ./bin/web .

run: templ-gen
	go run .

db-up:
	docker compose up -d --build

db-migrate:
	@echo "Migrating PostgreSQL schemas..."
	@goose -dir="./sql/schemas" postgres $(PSQL_DSN) up

db-migrate-down:
	@echo "Migrating down PostgreSQL schema..."
	@goose -dir="./sql/schemas" postgres $(PSQL_DSN) down

db-status:
	@goose -dir="./sql/schemas" postgres $(PSQL_DSN) status 

db-gen:
	@sqlc generate

db-psql:
	psql $(PSQL_DSN)

db-dump:
	pg_dump $(PSQL_DSN) > seed.sql

db-restore: 
	docker compose down -v --remove-orphans
	docker compose up -d --build
	@sleep 2s
	psql $(PSQL_DSN) < seed.sql 

db-down:
	@docker compose down --remove-orphans
	@echo "Removing DB..."

db-down-v:
	@docker compose down -v --remove-orphans
	@echo "Removing DB and volumes..."

db-restart: 
	@docker compose down -v --remove-orphans
	@echo "Removing DB..."
	@docker compose up -d 
	@sleep 1s
	@echo "Migrating PostgreSQL schemas..."
	@goose -dir="./sql/schemas" postgres $(PSQL_DSN) up

