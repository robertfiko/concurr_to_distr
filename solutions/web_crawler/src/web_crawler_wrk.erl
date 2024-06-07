-module(web_crawler_wrk).
-export([handle_call/3, handle_cast/2, init/1, start_link/0, get_job_nodes/0, crawl/1]).

-behaviour(gen_server). 
-define(MASTER_NODE, web_crawler@localhost).
-define(WORD, "water").


%%% INTERFACE %%%
get_job_nodes() ->
    gen_server:call(?MODULE, {get_job_nodes}).


%%% CALLBACKS %%%
init([]) ->
    {ok, []}.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


handle_call(_, _From, State) ->
    {reply, ok, State}.

handle_cast(prepare, State) ->
    io:format("Preparing to crawl~n"),
    worker_loop(),
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
            Result = do_task(Task),
            gen_server:call({web_crawler_mst, ?MASTER_NODE}, {send_result, Result}),
            io:format("Result: ~p~n", [Result]),
            worker_loop()
    end.


do_task(Task) ->
    StringBody = crawl(Task),
    count_word(?WORD, StringBody).

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
