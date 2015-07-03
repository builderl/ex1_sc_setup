-module(common_config).

-export([load_config/1]).

-define(DEFAULT_CONFIG_FILENAME, "local_setup.conf").

load_config(SetupCfg) ->
    Name = proplists:get_value(default_config,
                               SetupCfg, ?DEFAULT_CONFIG_FILENAME),
    File = filename:join(code:priv_dir(builderl_sample_setup), Name),

    io:format("Using configuration file: ~p~n", [File]),
    {ok, Config} = file:consult(File),
    Replace = proplists:get_value(install_key_replace, SetupCfg, []),
    io:format("But replacing the following keys:~n~p~n", [Replace]),
    bld_init:merge_config(Config, Replace).
