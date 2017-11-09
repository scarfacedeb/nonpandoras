defmodule Nonpandoras.Artwork do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Nonpandoras.{Artwork, Category}

  schema "artworks" do
    belongs_to :category, Category
    field :category_id, :integer
    field :dimensions, :string
    field :image, Nonpandoras.Image.Type
    field :is_available, :boolean, default: false
    field :is_published, :boolean, default: false
    field :slug, :string
    field :year, :string

    timestamps()
  end

  @doc false
  def changeset(%Artwork{} = artwork, attrs) do
    artwork
    |> cast(attrs, [:category_id, :slug, :is_published, :is_available, :year, :dimensions])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:category_id, :slug, :image, :is_published, :is_available, :year, :dimensions])
  end
end
