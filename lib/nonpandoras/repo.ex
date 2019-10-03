defmodule Nonpandoras.Repo do
  use Ecto.Repo,
    otp_app: :nonpandoras,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
