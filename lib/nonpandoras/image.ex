defmodule Nonpandoras.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]

  # Whitelist file extensions:
  # def validate({file, _}) do
  #   ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  # end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
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
