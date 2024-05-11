%%%-------------------------------------------------------------------
%% @doc cowboy_todo public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_todo_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {<<"localhost">>, [
            {<<"/">>, hello_handler, []},
            {<<"/task">>, todo_handler, {}}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(
        http,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    cowboy_todo_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
