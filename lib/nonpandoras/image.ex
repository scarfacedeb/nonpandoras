defmodule Nonpandoras.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @tile_1x 340
  @tiles [1, 1.5, 2, 3] |> Enum.map(&{&1, :"tile_#{&1}"})
  @versions [:original, :thumb] ++ Enum.map(@tiles, &elem(&1, 1))

  def tiles, do: @tiles

  def transform(:tile_1, _), do: resize(1)
  def transform(:"tile_1.5", _), do: resize(1.5)
  def transform(:tile_2, _), do: resize(2)
  def transform(:tile_3, _), do: resize(3)
  def transform(:thumb, _), do: resize(1, 250)

  defp resize(px_density \\ 1, base_size \\ @tile_1x) do
    size = ceil(base_size * px_density)
    dims = "#{size}x#{size}"
    {:convert, "-strip -thumbnail #{dims}^ -gravity center -extent #{dims} -format png", :png}
  end

  # Override the persisted filenames:
  def filename(version, _) do
    version
  end

  # Override the storage directory:
  def storage_dir(_version, {_file, %{slug: slug}}) when not is_nil(slug) do
    dir = Application.get_env(:nonpandoras, :uploads_dir)
    Path.join([dir, "artworks", slug])
  end

  def storage_dir(_, _) do
    dir = Application.get_env(:nonpandoras, :uploads_dir)
    Path.join([dir, "errors"])
  end

  def url_dir(_version, {_file, %{slug: slug}}) do
    Path.join(["uploads", "artworks", slug])
  end

  def url_dir(_version, _) do
    Path.join(["uploads", "errors"])
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
end
