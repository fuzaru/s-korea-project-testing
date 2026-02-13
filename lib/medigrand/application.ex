defmodule Medigrand.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MedigrandWeb.Telemetry,
      Medigrand.Repo,
      {DNSCluster, query: Application.get_env(:medigrand, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Medigrand.PubSub},
      MedigrandWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Medigrand.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    MedigrandWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
