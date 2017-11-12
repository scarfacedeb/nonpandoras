defmodule Nonpandoras.Artwork do
  use Ecto.Schema
  use Arc.Ecto.Schema
  use Trans, translates: [:title, :subtitle, :description, :technique]

  import Ecto.Changeset

  alias Nonpandoras.{Artwork, Category}

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

  @doc false
  def changeset(%Artwork{} = artwork, attrs) do
    artwork
    |> cast(attrs, [:category_id, :slug, :is_published, :year, :dimensions, :framed_dimensions, :is_available, :price_kopeks, :translations])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:category_id, :slug, :image])
  end
end
