defmodule Nonpandoras.AdminTest do
  use Nonpandoras.DataCase

  alias Nonpandoras.Admin

  describe "artworks" do
    alias Nonpandoras.Admin.Artwork

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def artwork_fixture(attrs \\ %{}) do
      {:ok, artwork} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_artwork()

      artwork
    end

    test "list_artworks/0 returns all artworks" do
      artwork = artwork_fixture()
      assert Admin.list_artworks() == [artwork]
    end

    test "get_artwork!/1 returns the artwork with given id" do
      artwork = artwork_fixture()
      assert Admin.get_artwork!(artwork.id) == artwork
    end

    test "create_artwork/1 with valid data creates a artwork" do
      assert {:ok, %Artwork{} = artwork} = Admin.create_artwork(@valid_attrs)
    end

    test "create_artwork/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_artwork(@invalid_attrs)
    end

    test "update_artwork/2 with valid data updates the artwork" do
      artwork = artwork_fixture()
      assert {:ok, artwork} = Admin.update_artwork(artwork, @update_attrs)
      assert %Artwork{} = artwork
    end

    test "update_artwork/2 with invalid data returns error changeset" do
      artwork = artwork_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_artwork(artwork, @invalid_attrs)
      assert artwork == Admin.get_artwork!(artwork.id)
    end

    test "delete_artwork/1 deletes the artwork" do
      artwork = artwork_fixture()
      assert {:ok, %Artwork{}} = Admin.delete_artwork(artwork)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_artwork!(artwork.id) end
    end

    test "change_artwork/1 returns a artwork changeset" do
      artwork = artwork_fixture()
      assert %Ecto.Changeset{} = Admin.change_artwork(artwork)
    end
  end
end
