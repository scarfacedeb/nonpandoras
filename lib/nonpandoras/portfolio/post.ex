defmodule Nonpandoras.Portfolio.Post do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :title, :string
    field :summary, :string
    field :body, :string

    field :slug, :string
    field :image, Nonpandoras.Image.Type

    field :is_published, :boolean
    field :published_at, :utc_datetime

    timestamps()
  end

  @cast_attrs ~w[title summary body slug is_published published_at]a
  @required_attrs ~w[slug title]a
  def changeset(%__MODULE__{} = post, attrs) do
    post
    |> cast(attrs, @cast_attrs)
    |> cast_attachments(attrs, [:image])
    |> put_published_at()
    |> validate_required(@required_attrs)
  end

  defp put_published_at(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{is_published: true}} ->
        changeset |> put_change(:published_at, DateTime.utc_now())

      _ ->
        changeset
    end
  end
end
