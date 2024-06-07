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

In the first part of the project, running `rebar3 shell` to test the solution, is enough.
We are not going to use distributed Erlang yet.

The tasks are:
1. Check the `web_crawler_wrk` (wrk = worker) module, implement the `do_task/1` function.
You can try your solution in the Erlang shell: `web_crawler_wrk:do_task(...)`
2. Described in source code: `web_crawler_wrk` module.
3. Described in source code: `web_crawler_wrk` module.
4. Described in source code: `web_crawler_wrk` module. The implementation of worker is done.
5. Now we need to add the worker to the supervision tree.
6. Implement handle_call for getting the job nodes.
7. Add the job node to the list of job nodes.
8. Described in source code: `web_crawler_mst` module.
9. Described in source code: `web_crawler_mst` module.
10. Described in source code: `web_crawler_mst` module.
11. Add `web_crawler_mst` to the supervision tree.

Now we have everything. `web_crawler` module is the interface, you can use the `run/1` function.
It requires a path to a file with the URLs to be crawled.

`urls.txt` is a file with some URLs to be crawled. (Top 20 longest Wikipedia articles)

## Limitations

- The State for the crawler master stores the job nodes in a list, a set would be better, to avoid duplicates.
- When a job is sent to a worker, the master node does not keep track of the worker that is processing the job. If a worker node is lost, the master node will not know that the job is lost. Obviously imporvment can be done, by tracking which worker is processing which job, and if needed reassign the job to another worker.
- The order of the tasks is not respected, the tasks are processed in the order they are received.
- The worker nodes only sends the "registration signal" to the master node when they start up. If the master node is started after the worker node, the worker remains unregistered for the master.

...probably many more.
