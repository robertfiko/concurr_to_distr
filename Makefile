docker-build:
	docker build -t erlang_demo .

docker-run:
	docker run -it --tty erlang_demo