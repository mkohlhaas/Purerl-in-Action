{ name = "my-project"
, dependencies = [ "console", "effect", "erl-process", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, backend = "purerl"
}
