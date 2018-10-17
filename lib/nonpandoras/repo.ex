defmodule Nonpandoras.Repo do
  use Ecto.Repo, otp_app: :nonpandoras
  use Scrivener, page_size: 10
end
