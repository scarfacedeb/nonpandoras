defmodule Nonpandoras.Portfolio.Category do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias Nonpandoras.Portfolio.{Artwork, Category}

  schema "categories" do
    field :title, :string
    field :description, :string

    field :slug, :string
    field :image, Nonpandoras.Image.Type
    field :position, :integer

    has_many :artworks, Artwork

    timestamps()
  end

  @cast_attrs ~w[slug position title description]a
  @required_attrs ~w[slug image title]a
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, @cast_attrs)
    |> cast_attachments(attrs, [:image])
    |> validate_required(@required_attrs)
  end
end
