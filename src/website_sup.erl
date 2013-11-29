-module(website_sup).
-behaviour(supervisor).
-include_lib("n2o/include/wf.hrl").
-export([start_link/0]).
-define(APP, we).
-export([init/1]).

-spec start_link() -> {ok, pid()}.

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  {ok, _} = cowboy:start_http(http, 100, [{port, 8000}],
                             [{env, [{dispatch, dispatch_rules()}]}]),
  Procs = [],
  {ok, {{one_for_one, 10, 10}, Procs}}.

dispatch_rules() ->
  cowboy_router:compile(
       [{'_', [
                    {"/static/[...]", cowboy_static, [{directory, {priv_dir, ?APP, [<<"static">>]}},
                                                      {mimetypes, {fun mimetypes:path_to_mimes/2, default}}]},
                    {"/ws/[...]", bullet_handler, [{handler, n2o_bullet}]},
                    {'_', n2o_cowboy, []}
                ]}]).
