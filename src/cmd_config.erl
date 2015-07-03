-module(cmd_config).

-export([
         subfolders/0,
         key_replace/4,
         process_config/4
        ]).

subfolders() ->
    {ok,
     [<<"mnesia_backups">>,
      <<"other_folder">>]}.

key_replace(_Base, _Name, Offset, RunVars) ->
    {_, _Host} = proplists:get_value(hostname, RunVars),

    {ok,
     [
      {<<"=EXAMPLE_IP=">>, <<"0.0.0.0">>},
      {<<"=EXAMPLE_PORT=">>, integer_to_list(8080 + Offset), [global]}
     ]}.

process_config({resource_discovery, _Name, _PrivDir},
               _CfgDir, _CfgArgs, _Privs) ->
    %% Some custom configuration instructions for resource_discovery
    true;
process_config(_App, _Dest, _CfgArgs, _Privs) ->
    false.
