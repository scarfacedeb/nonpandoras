defmodule Nonpandoras.Repo do
  use Ecto.Repo, otp_app: :nonpandoras
  require Ecto.Query

  @doc "Check if record exists"
  @spec exists?(Ecto.Query.t()) :: boolean()
  def exists?(queryable) do
    query =
      queryable
      |> Ecto.Query.select(1)
      |> Ecto.Query.limit(1)
      |> Ecto.Queryable.to_query()

    case all(query) do
      [1] -> true
      [] -> false
    end
  end
end
