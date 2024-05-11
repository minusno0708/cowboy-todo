-module(todo_handler).

-export([init/2]).

init(Req0, State) ->
    case maps:get(method, Req0) of
        <<"GET">> ->
            Req = cowboy_req:reply(
                200,
                #{<<"content-type">> => <<"text/plain">>},
                <<"Todo GET">>,
                Req0
            );
        <<"POST">> ->
            Req = cowboy_req:reply(
                200,
                #{<<"content-type">> => <<"text/plain">>},
                <<"Todo POST">>,
                Req0
            );
        _ ->
            Req = cowboy_req:reply(
                200,
                #{<<"content-type">> => <<"text/plain">>},
                <<"Todo">>,
                Req0
            )
        end,
    {ok, Req, State}.