templ-gen:
	templ generate

build:
	go build -o ./bin/web .

run: templ-gen
	go run .


