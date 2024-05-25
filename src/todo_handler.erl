-module(todo_handler).

-export([init/2]).

init(Req0, State) ->
    Method = cowboy_req:method(Req0),
    HasBody = cowboy_req:has_body(Req0),
    Req = router(Method, HasBody, Req0),
    {ok, Req, State}.

router(<<"GET">>, _, Req0) ->
    {ok, _, Rows} = database:get_tasks(),
    cowboy_req:reply(
        200,
        #{<<"content-type">> => <<"application/json">>},
        jsone:encode(Rows),
        Req0
    );

router(<<"POST">>, true, Req0) ->
    {ok, Body, _} = cowboy_req:body(Req0),
    io:format("Body: ~p~n", [Body]),
    database:create_task(),
    cowboy_req:reply(
        200,
        #{<<"content-type">> => <<"application/json">>},
        <<"{'message': 'upload task'}">>,
        Req0
    );

router(_, _, Req0) ->
    cowboy_req:reply(
        404,
        #{<<"content-type">> => <<"text/plain">>},
        <<"Not Found">>,
        Req0
    ).
