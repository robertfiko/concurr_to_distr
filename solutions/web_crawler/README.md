# Web Crawler - Distributed Erlang Example

Note: this is a simple example to demonstrate how to use distributed Erlang. 

## How to run
- `make release`: to compile and generate a release
- `make main`: to start the main node
- `make b1`: to starts a worker node, named `web_crawler_b1`
- `make b2`: to starts a worker node, named `web_crawler_b2`
- `make b3`: to starts a worker node, named `web_crawler_b3`
There is no rule to start more than 3 worker nodes, but you can start as many as you want.

If something goes wrong a usefull command to stop a node, if you don't have access to its shell:
```
erl -eval 'rpc:call(web_crawler_b1@localhost, init, stop, []), halt().' -sname killer -setcookie web_crawler
```
## Tasks



## Limitations

- The State for the crawler master stores the job nodes in a list, a set would be better, to avoid duplicates.
- When a job is sent to a worker, the master node does not keep track of the worker that is processing the job. If a worker node is lost, the master node will not know that the job is lost. Obviously imporvment can be done, by tracking which worker is processing which job, and if needed reassign the job to another worker.
- The order of the tasks is not respected, the tasks are processed in the order they are received.
- The worker nodes only sends the "registration signal" to the master node when they start up. If the master node is started after the worker node, the worker remains unregistered for the master.

...probably many more.
