-module(fibonacci).
-compile([export_all]).

% TASK 1:
% Implement the fibonacci function
% that calculates the nth fibonacci number
% using sequential recursion

%fibonacci(???) -> ???;


% TASK 2:
% Implement the fibonacci function
% that calculates the nth fibonacci number
% using multiple a sub process for each sub calculation
% 
% First implement the base cases
% Keep in mind that the result should be sent to the process
% that is waiting for it.
% fibonacci_parallel(???, ???) -> ???;

 
% Now implement the recursive case
% Spawn the two sub processes, that will calculate the two sub results: N-1 and N-2
% Then wait for the results from the two sub processes
% fibonacci_parallel(???, ???) -> ???.

