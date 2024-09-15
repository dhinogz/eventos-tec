include .env

PSQL_DSN = "postgres://${PSQL_USER}:${PSQL_PASSWORD}@${PSQL_HOST}:${PSQL_PORT}/${PSQL_DATABASE}?sslmode=${PSQL_SSLMODE}"

deps: # Installs templ and and npm dependencies
	go install github.com/a-h/templ/cmd/templ@latest
	go install github.com/pressly/goose/v3/cmd/goose@latest
	npm install

templ: # Generate templ files
	templ generate

assets: # Generate CSS based on templ files
	npx tailwindcss -m -i ./assets/tailwind.css -o ./assets/dist/styles.min.css

embed: templ assets # Embed generated assets
	go generate ./...

build: embed
	go build -o ./bin/web .

run: build
	./bin/web

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

db-seed:
	psql $(PSQL_DSN) -f seed.sql

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

# Live mode
.PHONY: live/wgo
live/wgo:
	wgo -file .go -xfile=_templ.go go run main.go serve :: \
	wgo -file .css templ generate --notify-proxy

.PHONY: live/proxy
live/proxy:
	templ generate --watch --proxy="http://127.0.0.1:42069" --open-browser=false

.PHONY: live
live:
	$(MAKE) --no-print-directory -j3 live/proxy live/wgo
