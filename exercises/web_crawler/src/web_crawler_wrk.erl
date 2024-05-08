-module(web_crawler_wrk).
-export([handle_call/3, handle_cast/2, init/1, start_link/0, do_task/1]).

-behaviour(gen_server). 
-define(MASTER_NODE, web_crawler@localhost).


%%% CALLBACKS %%%
init([]) ->
    {ok, []}.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


handle_call(_, _From, State) ->
    {reply, ok, State}.

% TASK 4: the master node should send a prepare message to the worker node
% when there are tasks to be done. 
handle_cast(prepare, State) ->
    io:format("Preparing to crawl~n"),
    
    % TASK 4.1: here we need to enter to a loop, where we will be requesting tasks
    % and processing them. See TASK 2.

    {noreply, State};

handle_cast(_, State) ->
    {noreply, State}.


worker_loop() ->
    io:format("Worker loop~n"),

    case gen_server:call({web_crawler_mst, ?MASTER_NODE}, get_task) of
        no_task -> 
            io:format("No task~n"),
            ok;
        Task -> 
            io:format("Task: ~p~n", [Task]),
            Result = undefined, % TASK 2: calculate the result of the task
            % TASK 3: send the result back to the master node, get inspiration from
            % the case statement a few lines above. You need to send back the result 
            % as {send_result, Result}

            io:format("Result: ~p~n", [Result]),
            worker_loop()
    end.


do_task(Task) ->
    % TASK 1: implement the do_task function
    % use the crawl/1 function to get the text from the URL
    % use the count_word/2 function to count the number of occurrences of the word "water" in the text
    undefined.

crawl(Url) ->
    Method = get,
    URL = list_to_binary(Url),
    Headers = [],
    Payload = <<>>,
    Options = [],
    {ok, StatusCode, RespHeaders, ClientRef} = hackney:request(Method, URL,
                                                        Headers, Payload,
                                                        Options),
    {ok, Body} = hackney:body(ClientRef),
    binary_to_list(Body).



count_word(Word, Text) ->
    count_word(Word, Text, 0).

count_word(_, [], Count) ->
    Count;
count_word(Word, Text, Count) ->
    case lists:prefix(Word, Text) of
        true -> count_word(Word, lists:nthtail(length(Word), Text), Count + 1);
        false -> count_word(Word, tl(Text), Count)
    end.
