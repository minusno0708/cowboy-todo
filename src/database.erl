-module(database).

-export([create_task/0, get_tasks/0]).

db_connection() ->
    epgsql:connect(#{
        host => "localhost",
        username => "postgres",
        password => "postgres",
        database => "todo_db",
        port => 5432,
        tiemout => 5000}
    ).

create_task() ->
    {ok, C} = db_connection(),
    {ok, _} = epgsql:squery(C, "insert into tasks (title) values ('Task 1')"), 
    ok = epgsql:close(C).

get_tasks() ->
    {ok, C} = db_connection(),
    {ok, Columns, Rows} = epgsql:equery(C, "select * from tasks"),
    io:format("~p~n", [Columns]),
    io:format("~p~n", [Rows]),
    ok = epgsql:close(C).
