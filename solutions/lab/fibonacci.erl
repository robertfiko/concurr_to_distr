-module(fibonacci).
-compile([export_all]).

% TASK 1:
% Implement the fibonacci function
% that calculates the nth fibonacci number
% using sequential recursion

fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N-1) + fib(N-2).


% TASK 2:
% Implement the fibonacci function
% that calculates the nth fibonacci number
% using multiple a sub process for each sub calculation
% 
% First implement the base cases
% Keep in mind that the result should be sent to the process
% that is waiting for it.
fibpar(0, Pid) -> Pid ! {self(), 0};
fibpar(1, Pid) -> Pid ! {self(), 1};
fibpar(N, Pid) ->
    SelfPid = self(),
    Left = spawn(fun () -> fibpar(N-1, SelfPid) end),
    Right = spawn(fun () -> fibpar(N-2, SelfPid) end),

    LV = receive {Left, L} -> L end,
    RV = receive {Right, R} -> R end,
    Pid ! {self(), LV + RV}.


 
% Now implement the recursive case
% Spawn the two sub processes, that will calculate the two sub results: N-1 and N-2
% Then wait for the results from the two sub processes
% fibonacci_parallel(???, ???) -> ???.

