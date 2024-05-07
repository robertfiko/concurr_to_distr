-module(ping_pong).

% Compiler flag, which exports all of the functions
% generally should not be used, but it is easier now
-compile([export_all]).

% Task 1:
% Write the function for the the process that supposed
% to receive the message and reply with pong
ponger_fun() ->
    undefined.

ping() -> 
    Pid = spawn(fun ponger_fun/0),

    % Task 2:
    % Send the message to the process
    
    % This will block, until the correct message is received
    receive pong -> ok end.

% TEST:
% Compile, and run `erl`, then: ping_pong:ping().