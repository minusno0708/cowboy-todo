%%%-------------------------------------------------------------------
%% @doc cowboy_todo public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_todo_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    cowboy_todo_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
