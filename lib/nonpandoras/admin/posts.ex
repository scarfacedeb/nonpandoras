defmodule Nonpandoras.Admin.Posts do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias Nonpandoras.Repo

  alias Nonpandoras.Portfolio.Post

  @doc "Returns the list of posts"
  def list_posts do
    Post
    |> order_by(desc: :id)
    |> Repo.all()
  end

  @doc "Gets a single post."
  def get_post!(slug), do: Repo.get_by(Post, slug: slug)

  @doc "Creates a post."
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Updates a post."
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc "Deletes a Post."
  def delete_post(%Post{} = post) do
    post
    |> Repo.delete()
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
