[
  import_deps: [:phoenix, :plug, :ecto],
  inputs: [
    "{config,lib,test}/**/*.{ex,exs}",
    "*.exs"
  ],
  locals_without_parens: [
    resources: 3,
    pipe_through: 1
  ]
]
