defmodule NonpandorasWeb.Admin.ArtworkControllerTest do
  use NonpandorasWeb.ConnCase

  alias Nonpandoras.Admin

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:artwork) do
    {:ok, artwork} = Admin.create_artwork(@create_attrs)
    artwork
  end

  describe "index" do
    test "lists all artworks", %{conn: conn} do
      conn = get conn, admin_artwork_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Artworks"
    end
  end

  describe "new artwork" do
    test "renders form", %{conn: conn} do
      conn = get conn, admin_artwork_path(conn, :new)
      assert html_response(conn, 200) =~ "New Artwork"
    end
  end

  describe "create artwork" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, admin_artwork_path(conn, :create), artwork: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == admin_artwork_path(conn, :show, id)

      conn = get conn, admin_artwork_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Artwork"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, admin_artwork_path(conn, :create), artwork: @invalid_attrs
      assert html_response(conn, 200) =~ "New Artwork"
    end
  end

  describe "edit artwork" do
    setup [:create_artwork]

    test "renders form for editing chosen artwork", %{conn: conn, artwork: artwork} do
      conn = get conn, admin_artwork_path(conn, :edit, artwork)
      assert html_response(conn, 200) =~ "Edit Artwork"
    end
  end

  describe "update artwork" do
    setup [:create_artwork]

    test "redirects when data is valid", %{conn: conn, artwork: artwork} do
      conn = put conn, admin_artwork_path(conn, :update, artwork), artwork: @update_attrs
      assert redirected_to(conn) == admin_artwork_path(conn, :show, artwork)

      conn = get conn, admin_artwork_path(conn, :show, artwork)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, artwork: artwork} do
      conn = put conn, admin_artwork_path(conn, :update, artwork), artwork: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Artwork"
    end
  end

  describe "delete artwork" do
    setup [:create_artwork]

    test "deletes chosen artwork", %{conn: conn, artwork: artwork} do
      conn = delete conn, admin_artwork_path(conn, :delete, artwork)
      assert redirected_to(conn) == admin_artwork_path(conn, :index)

      assert_error_sent 404, fn ->
        get conn, admin_artwork_path(conn, :show, artwork)
      end
    end
  end

  defp create_artwork(_) do
    artwork = fixture(:artwork)
    {:ok, artwork: artwork}
  end
end
