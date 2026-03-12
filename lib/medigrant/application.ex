defmodule Medigrant.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MedigrantWeb.Telemetry,
      Medigrant.Repo,
      {DNSCluster, query: Application.get_env(:medigrant, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Medigrant.PubSub},
      MedigrantWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Medigrant.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    MedigrantWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
