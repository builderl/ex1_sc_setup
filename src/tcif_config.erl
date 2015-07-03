-module(tcif_config).

-export([install/2]).

log(F0, A0) ->
    F1 = "~p:~p: " ++ F0 ++ "~n",
    A1 = [?MODULE, ?LINE] ++ A0,
    io:format(F1, A1).

install({_Id, _Node}, SetupCfg) ->
    Config = common_config:load_config(SetupCfg),
    log("Config file: ~p~n", [Config]),

    ok.
