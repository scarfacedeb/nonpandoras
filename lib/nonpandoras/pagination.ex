defmodule Nonpandoras.Pagination do
  import Ecto.Query, only: [limit: 2, offset: 2, where: 3]
  alias Nonpandoras.Repo

  @page_size 10

  def paginate(query, %{"page" => page}) do
    query =
      case calc_offset(page) do
        offset_val ->
          query |> offset(^offset_val)

        _ ->
          query
      end

    query |> paginate()
  end

  def paginate(query, _), do: paginate(query)
  def paginate(query), do: limit(query, @page_size)

  defp calc_offset(""), do: nil

  defp calc_offset(value) do
    case Integer.parse(value) do
      {page, ""} when page > 0 ->
        (page - 1) * @page_size

      _ ->
        nil
    end
  end
end
