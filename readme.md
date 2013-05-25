Colosimo is a [Chicago Boss](http://www.chicagoboss.org) sample project demonstrating:
* basic templating
* user registration/login form with email validation
* usage of controller's before_
* protected pages
* protected pages redirect url with a querystring
* starting bcrypt using priv/init/colosimo_03_brcrypt.erl module
* password encryption with bcrypt (using [erlang-bcrypt](https://github.com/smarkets/erlang-bcrypt))

Before starting Colosimo, make sure to open ../ChicagoBoss/rebar.config and add bcrypt to the list of deps:

```
{bcrypt, "0.5.0", {git, "https://github.com/smarkets/erlang-bcrypt.git", {tag, "0.5.0"}}}
```

Once brcypt is added to ChicagoBoss rebar.config, in ChicagoBoss directory execute:

```
rebar get-deps
rebar compile
```

That will instruct rebar to download bcrypt into ChicagoBoss deps directory and compile it.

After bcrypt is installed, switch back into colosimo directory and execute:

```
./init-dev.sh
```

Then visit [http://localhost:8001/](http://localhost:8001/) and create a login.

Unlike the upstream of Colosimo, this fork does not use PostgreSQL, instead all data is in memory
and during the cold start or restarts, account information gets erased.
