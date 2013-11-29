-module(website_app).
-include_lib("n2o/include/wf.hrl").
-behaviour(application).
-define(APP, web).
-export([start/2, start/0, stop/1]).

startDeps() ->
  application:start(sasl),
  application:start(crypto),
  application:start(syntax_tools),
  application:start(compiler),
  application:start(erlydtl),
  application:start(mimetypes),
  application:start(ranch),
  application:start(cowlib),
  application:start(cowboy),
  application:start(gproc),
  application:start(n2o).

start() ->
  start([],[]).

start(_Type, _Args) ->
  startDeps(),
  website_sup:start_link().

stop(_State) ->
  ok.
