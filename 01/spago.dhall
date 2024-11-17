{ name = "my-project"
, dependencies =
  [ "console", "datetime", "effect", "erl-kernel", "erl-process", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, backend = "purerl"
}
