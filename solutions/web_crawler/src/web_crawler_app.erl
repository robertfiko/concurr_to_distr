%%%-------------------------------------------------------------------
%% @doc web_crawler public API
%% @end
%%%-------------------------------------------------------------------

-module(web_crawler_app).

-behaviour(application).

-export([start/2, stop/1, master_node/0]).

start(_StartType, _StartArgs) ->
    Link = web_crawler_sup:start_link(),
    MasterNode = master_node(),

    io:format("Current node: ~p~n", [node()]),
    io:format("Master node: ~p~n", [MasterNode]),

    case node() of
        MasterNode ->
            io:format("I am master~n"),
            ok; % we are master
        _ ->
            io:format("I am not master~n"),
            gen_server:call({web_crawler_mst, MasterNode}, {job_node, node()})
    end,
    Link.

stop(_State) ->
    ok.

%% internal functions
master_node() -> 
    web_crawler@localhost. 
 
