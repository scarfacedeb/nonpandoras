defmodule Nonpandoras.Portfolio do
  import Ecto.Query, warn: false

  alias Nonpandoras.Repo
  alias Nonpandoras.Pagination
  alias Nonpandoras.Portfolio.{Artwork, Category}

  def get_category!(slug), do: Repo.get_by!(Category, slug: slug)
  def get_artwork!(slug), do: Repo.get_by!(Artwork, slug: slug)

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
    |> Pagination.paginate(params)
    |> Repo.all()
  end

  def get_categories() do
    Category
    |> order_by(asc: :id)
    |> Repo.all()
  end

  def create_artwork(attrs \\ %{}) do
    %Artwork{}
    |> Artwork.changeset(attrs)
    |> Repo.insert()
  end

  def update_artwork(%Artwork{} = artwork, attrs) do
    artwork
    |> Artwork.changeset(attrs)
    |> Repo.update()
  end

  def delete_artwork(%Artwork{} = artwork) do
    Repo.delete(artwork)
  end
end