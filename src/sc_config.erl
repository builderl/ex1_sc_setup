-module(sc_config).

-export([install/2]).

log(F0, A0) ->
    F1 = "~p:~p: " ++ F0 ++ "~n",
    A1 = [?MODULE, ?LINE] ++ A0,
    io:format(F1, A1).

install(Cluster, SetupCfg) ->
    Config = common_config:load_config(SetupCfg),
    log("Config file: ~p~n", [Config]),

    Nodes = [Remote || {_Id, Remote} <- Cluster],

    ok = mnesia:create_schema(Nodes),
    verify(rpc:multicall(Nodes, mnesia, start, [])),

    %% application:start(inets),
    ok.

verify({OKs, []} = Err) ->
    lists:usort(OKs) =:= [ok] orelse verify_error(Err);
verify({[ok], []}) ->
    ok;
verify(Err) ->
    verify_error(Err).

verify_error(Err) ->
    io:format(standard_error, "Returned error:'~p', aborting...~n", [Err]).
