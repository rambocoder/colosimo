-module(user_lib).
-compile(export_all).

require_login(Req) ->
  case Req:cookie("colosimo_user_id") of
    undefined -> {ok, []};
    Id ->
      case boss_db:find(Id) of
        undefined -> {ok, []};
        ColosimoUser ->
          case ColosimoUser:session_identifier() =:= Req:cookie("session_id") of
            false -> {ok, []};
            true -> {ok, ColosimoUser}
          end
      end
  end.

check_password_and_login(Req, ColosimoUser) ->
  case ColosimoUser:check_password(Req:post_param("password")) of
    true ->
      RedirectUrl = Req:query_param("returlUrl", "/"),
      {redirect, RedirectUrl, ColosimoUser:set_login_cookies()};
    false ->
      {ok, [{error, "Authentication error: password check failed"}]}
  end.

remove_cookies() ->
  mochiweb_cookies:cookie("colosimo_user_id", "", [{path, "/"}]),
  mochiweb_cookies:cookie("session_id", "", [{path, "/"}]).

get_hash(Password) ->
  {ok, Salt} = bcrypt:gen_salt(),
  {ok, Hash} = bcrypt:hashpw(Password, Salt),
  Hash.

register_user(Req) ->
  HashedPassword = user_lib:get_hash(Req:post_param("password")),
  ColosimoUser = colosimo_user:new(id, Req:post_param("email"), Req:post_param("username"), HashedPassword),
  ColosimoUser:save().
