.PHONY: build run

NAME := "docker-slack"

build:
	docker build . -t $(NAME)

run:
	docker run --rm -e WEBHOOK_URL="$(ENV)" $(NAME)
