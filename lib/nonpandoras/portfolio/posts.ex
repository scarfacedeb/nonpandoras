defmodule Nonpandoras.Portfolio.Posts do
  import Ecto.Query, warn: false

  alias Nonpandoras.Repo
  alias Nonpandoras.Portfolio.Post
  alias Nonpandoras.Pagination

  def get_post!(slug), do: Repo.get_by!(Post, slug: slug)

  def list_posts(params) do
    Post
    |> where(is_published: true)
    |> order_by(desc: :id)
    |> Pagination.paginate(params)
    |> Repo.all()
  end
end
