defmodule NonpandorasWeb.TranslationForm do
  @locales ~w{en ru cz}

  require IEx

  def translations_for(form, attr \\ :translations, fun) do
    @locales
    |> Enum.map(&to_form(form, attr, &1))
    |> Enum.map(&fieldset(&1, fun))
    |> Phoenix.HTML.html_escape()
  end

  defp to_form(form, attr, locale) do
    id = to_string(form.id <> "_#{locale}")
    name = to_string(form.name <> "[#{attr}][#{locale}]")
    data = form_data(form, attr, locale)
    params = form_params(form, attr, locale)

    source = Map.put(form.source, :data, data)
    form = Map.put(form, :source, source)

    %Phoenix.HTML.Form{
      source: form.source,
      impl: form.impl,
      id: id,
      name: name,
      errors: form_for_errors(form.source),
      data: data,
      params: params || %{},
      hidden: [],
      options: []
    }
  end

  defp form_data(%{data: data}, attr, locale) do
    data
    |> Map.fetch!(attr)
    |> Map.get(locale, %{})
    |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
    |> Enum.into(%{locale: locale})
  end

  defp form_params(%{params: params}, attr, locale) do
    get_in(params, [to_string(attr), to_string(locale)]) || %{}
  end

  defp form_for_errors(%{action: nil}), do: []
  defp form_for_errors(%{errors: errors}), do: errors

  defp fieldset(nested_form, fun) do
    hidden = Enum.map(nested_form.hidden, fn {k, v} -> Phoenix.HTML.Form.hidden_input(nested_form, k, value: v) end)
    [hidden, fun.(nested_form)]
  end
end
