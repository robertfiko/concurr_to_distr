-module(web_crawler_mst).
-export([handle_call/3, handle_cast/2, init/1, start_link/0, get_job_nodes/0, handle_continue/2]).

-behaviour(gen_server). 

-record(state, {
    job_nodes = [] :: [atom()],
    tasks = [] :: [string()], % list of URLs
    to_pid = undefined :: pid(),
    results = [] :: [integer()],
    total_tasks = 0 :: integer()
}).

%%% INTERFACE %%%
get_job_nodes() ->
    gen_server:call(?MODULE, get_job_nodes).


%%% CALLBACKS %%%
init([]) ->
    {ok, #state{}}.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

handle_call({job_node, Node}, _From, State) ->
    {reply, ok, State#state{job_nodes = [Node | State#state.job_nodes]}};

handle_call(get_job_nodes, _From, State) ->
    {reply, State#state.job_nodes, State};

handle_call(get_task, _From, State) ->
    io:format("Task was requested, tasks: ~p~n", [State#state.tasks]),
    case State#state.tasks of
        [] -> {reply, no_task, State};
        [Task|Tasks] -> {reply, Task, State#state{tasks = Tasks}}
    end;

handle_call({send_result, Result}, _From, State) ->
    io:format("Result arrived: ~p~n", [Result]),
    TotalTasks = State#state.total_tasks,
    case length(State#state.results) + 1 of
        TotalTasks -> 
            io:format("All results arrived: ~p~n", [State#state.results]),
            State#state.to_pid ! {results, [Result | State#state.results]},
            {reply, ok, State#state{results = []}};
        _ -> 
            {reply, ok, State#state{results = [Result | State#state.results]}}
    end;

handle_call(_, _From, State) ->
    {reply, ok, State}.




handle_cast({task, Urls, From}, State) ->
    io:format("Received task: ~p~n", [Urls]),
    {noreply, State#state{tasks = Urls, to_pid = From, total_tasks = length(Urls)}, {continue, prepare}};


handle_cast(_, State) ->
    {noreply, State}.



handle_continue(prepare, State) ->
    JobNodes = State#state.job_nodes,
    io:format("Job nodes: ~p~n", [JobNodes]),
    [ gen_server:cast({web_crawler_wrk, Node}, prepare) || Node <- JobNodes ],
    {noreply, State}.