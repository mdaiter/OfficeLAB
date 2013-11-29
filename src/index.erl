-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").
-include_lib("avz/include/avz.hrl").

title() -> "N2O".

body() ->
  [
    #label{body = "asdf"},
    #textbox{body = "asfd"}
  ].

main() ->
  #dtl{file="index", ext="dtl", app=we }.
