-module(web_crawler).
-export([run/1]).

run(FilePath) ->
    % read file
    {ok, File} = file:read_file(FilePath),
    FileS = binary_to_list(File),
    Lines = string:tokens(FileS, "\n"),
    
    {Time, Value} = timer:tc(fun() -> 
        gen_server:cast(web_crawler_mst, {task, Lines, self()}),
        receive
            {results, Results} -> Results
        end
    end),
    io:format("Time: ~p~n", [Time]),
    Value.
    