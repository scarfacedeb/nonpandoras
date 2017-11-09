defmodule Nonpandoras.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :slug, :string, null: false
      add :image, :string
      add :position, :integer, default: 100

      timestamps()
    end

    create index(:categories, [:slug], unique: true)
  end
end
