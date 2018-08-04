defmodule Nonpandoras.Portfolio.Artwork do
  use Ecto.Schema
  use Arc.Ecto.Schema
  use Trans, translates: [:title, :subtitle, :description, :technique]

  import Ecto.Changeset

  alias Nonpandoras.Portfolio.{Artwork, Category}

  schema "artworks" do
    field :title, :string, virtual: true
    field :subtitle, :string, virtual: true
    field :description, :string, virtual: true
    field :technique, :string, virtual: true
    field :translations, :map

    field :slug, :string
    field :is_published, :boolean, default: true
    field :image, Nonpandoras.Image.Type
    field :year, :string
    field :dimensions, :string
    field :framed_dimensions, :string

    field :is_available, :boolean, default: false
    field :price_kopeks, :integer

    belongs_to :category, Category

    timestamps()
  end

  @cast_attrs ~w[category_id slug is_published year dimensions framed_dimensions is_available price_kopeks translations]a
  @required_attrs ~w[category_id slug image]a
  def changeset(%Artwork{} = artwork, attrs) do
    artwork
    |> cast(attrs, @cast_attrs)
    |> cast_attachments(attrs, [:image])
    |> validate_required(@required_attrs)
  end
end
