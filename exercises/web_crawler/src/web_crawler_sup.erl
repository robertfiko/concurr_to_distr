%%%-------------------------------------------------------------------
%% @doc web_crawler top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(web_crawler_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    ChildSpecs = [
        % TASK 5: add web_crawler_wrk to the list of children
        % 
        % #{id => web_crawler_wrk,
        %   start => {web_crawler_mst, start_link, []},
        %   restart => permanent,
        %   shutdown => 5000,
        %   type => worker,
        %   modules => [web_crawler_mst]},

        % TASK 11: add web_crawler_mst to the list of children
    ],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
