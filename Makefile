PWD = $(shell pwd)

docker-build:
	docker build -t erlang_demo .

docker-run:
	docker run -v "$(PWD)":/app -it --tty erlang_demo