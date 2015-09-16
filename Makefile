all: build

build:
	@docker build -t ${USER}/transmission .
