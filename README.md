# Erlang's Path: Concurrency to Seamless Distribution

Exercises can be found in the `exercises` directory and the solutions in the `solutions` directory.
The presentation is uploaded as [presentation.pdf](presentation.pdf).

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

The container has your current working directory attached as a volume, so you can
work on your host system, while run the code in the container.

The next step what is needed is to attach VS Code to the container:
[Attach to a running container | VS Code docs](https://code.visualstudio.com/docs/devcontainers/attach-container)

You can exit from the container with `exit`.

I recommend to install this extension : [Erlang LS](https://marketplace.visualstudio.com/items?itemName=erlang-ls.erlang-ls)