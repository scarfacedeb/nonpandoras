defmodule Nonpandoras.Application do
  use Application

  def start(_type, _args) do
    children = [
      Nonpandoras.Repo,
      NonpandorasWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Nonpandoras.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    NonpandorasWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def env do
    Application.get_env(:nonpandoras, :environment)
  end
end
