-module(fibonacci).
-compile([export_all]).

% TASK 1:
% Implement the fibonacci function
% that calculates the nth fibonacci number
% using sequential recursion

fibonacci(0) -> 0;
fibonacci(1) -> 1;
fibonacci(N) -> fibonacci(N-1) + fibonacci(N-2).

% TASK 2:
% Implement the fibonacci function
% that calculates the nth fibonacci number
% using multiple a sub process for each sub calculation

fibonacci_parallel(0, Pid) -> Pid ! {self(), 0};
fibonacci_parallel(1, Pid) -> Pid ! {self(), 1};
fibonacci_parallel(N, Pid) ->
    Self = self(), 
    Pid1 = spawn(fun() -> fibonacci_parallel(N-1, Self) end),
    Pid2 = spawn(fun() -> fibonacci_parallel(N-2, Self) end),
    receive
        {Pid1, Result1} -> 
            receive
                {Pid2, Result2} -> Pid ! {self(), Result1 + Result2}
            end
    end.