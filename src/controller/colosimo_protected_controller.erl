-module(colosimo_protected_controller, [Req]).
-compile(export_all).

before_(ActionName, RequestMethod, UrlTokensList) ->
  {ok, User} = user_lib:require_login(Req),
  
  error_logger:info_msg("Found user: ~p~n",[User]),
  error_logger:info_msg("Accessing Uri: ~p~n",[Req:uri()]),

  case User of
    [] -> {redirect, "/user/login?returlUrl=" ++ http_uri:encode(Req:uri())};
  	User -> {ok, [{current_user, User}]}
  end.

index('GET', []) ->
  {ok, []}.

do('GET', []) ->
  {ok, [{a, Req:query_param("a")}, {b, Req:query_param("b")}, {c, Req:query_param("c")}]}.
