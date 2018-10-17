defmodule Nonpandoras.Portfolio do
  import Ecto.Query, warn: false

  alias Nonpandoras.Repo
  alias Nonpandoras.Portfolio.{Artwork, Category, Post, Page}

  def get_category!(slug), do: Repo.get_by!(Category, slug: slug)
  def get_artwork!(slug), do: Repo.get_by!(Artwork, slug: slug)
  def get_page!(slug), do: Repo.get_by!(Page, slug: slug)

  def get_prev(%{id: id, category_id: category_id}) do
    Artwork
    |> where([a], a.id > ^id)
    |> where(category_id: ^category_id)
    |> order_by(asc: :id)
    |> limit(1)
    |> Repo.one()
  end

  def get_next(%{id: id, category_id: category_id}) do
    Artwork
    |> where([a], a.id < ^id)
    |> where(category_id: ^category_id)
    |> order_by(desc: :id)
    |> limit(1)
    |> Repo.one()
  end

  def list_artworks_in_category(%{id: category_id}, params) do
    Artwork
    |> where(category_id: ^category_id)
    |> order_by(desc: :id)
    |> Repo.paginate(params)
  end
    |> Repo.all()
  end

  def list_sidebar_pages do
    Page
    |> where(is_sidebar: true)
    |> order_by(:position)
    |> Repo.all()
  end

  def get_categories() do
    Category
    |> order_by(asc: :id)
    |> Repo.all()
  end
end
