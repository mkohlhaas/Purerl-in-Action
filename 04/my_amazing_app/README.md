my_amazing_app
=====

An OTP application

Directories
-----------

Directory structure created with:
```shell
rebar3 new app my_amazing_app
```

`server` subdirectory created with:
```shell
git clone https://github.com/mkohlhaas/PureScript-Erlang-Template.git server
```

Build
-----

```shell
rebar3 clean
rebar3 compile
erl -pa _build/default/lib/my_amazing_app/ebin/
```

Erlang Shell
```
Eshell V14.0 (press Ctrl+G to abort, type help(). for help)
1> application:start(my_amazing_app).
ok
2> application:stop().
```

Self-contained release
```
rebar3 tar
===> Tarball successfully created: _build/default/rel/my_amazing_app/my_amazing_app-0.0.1.tar.gz
# unzip generated tar.gz file in any directory
./bin/my_amazing_app
./bin/my_amazing_app console
./bin/my_amazing_app pid
./bin/my_amazing_app stop
```

Usage
-----

```shell
# call genserver API function
(myGenServer@ps:doSomething())().
<<"Hi">>
```
