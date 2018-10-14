[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  import_deps: [:ecto, :plug, :phoenix],
  line_length: 120,
  locals_without_parens: [
    ## Ecto migrations
    create: :*,
    create_if_not_exists: :*,
    alter: :*,
    drop: :*,
    drop_if_exists: :*,
    rename: :*,
    add: :*,
    remove: :*,
    modify: :*,
    execute: :*
  ]
]
