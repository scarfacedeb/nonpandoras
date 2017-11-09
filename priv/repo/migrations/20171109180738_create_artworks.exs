defmodule Nonpandoras.Repo.Migrations.CreateArtworks do
  use Ecto.Migration

  def change do
    create table(:artworks) do
      add :category_id, references(:categories), null: false
      add :slug, :string, null: false
      add :image, :string, null: false
      add :is_published, :boolean, default: false, null: false
      add :is_available, :boolean, default: true, null: false
      add :year, :string
      add :dimensions, :string

      timestamps()
    end

    create index(:artworks, [:slug], unique: true)
    create index(:artworks, [:category_id])
  end
end
