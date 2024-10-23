{ name = "my-project"
, dependencies =
  [ "console"
  , "datetime"
  , "effect"
  , "erl-atom"
  , "erl-lists"
  , "erl-pinto"
  , "maybe"
  , "prelude"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, backend = "purerl"
}
