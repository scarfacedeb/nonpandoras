defmodule Nonpandoras.Portfolio.Posts do
  import Ecto.Query, warn: false

  alias Nonpandoras.Repo
  alias Nonpandoras.Portfolio.Post

  def get_post!(slug), do: Repo.get_by!(Post, slug: slug)

  def list_posts(params) do
    Post
    |> where(is_published: true)
    |> order_by(desc: :id)
    |> Repo.paginate(params)
  end

  def list_last_posts(limit \\ 5) do
    Post
    |> where(is_published: true)
    |> order_by(desc: :id)
    |> limit(^limit)
    |> Repo.all()
  end
end
