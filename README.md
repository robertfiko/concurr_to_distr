# Erlang – From Concurrent to Distributed

This repository will be updated with the exercises.

## Prerequisites

To ensure the same environment, please build and use the Docker image:

1. `make docker-build` will build the needed the image with the files to work with as well.
2. `make docker-run` will start a shell inside the Docker container
3. Inside the the container please type: `erl`, you should get something like this
```
Erlang/OTP 25 [erts-13.2.2.9] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit:ns]

Eshell V13.2.2.9  (abort with ^G)
1> 
```
Congrats! You have your environment ready!

You can exit from the container with `exit`.