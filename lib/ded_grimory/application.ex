defmodule DedGrimory.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DedGrimoryWeb.Telemetry,
      # Start the Ecto repository
      DedGrimory.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DedGrimory.PubSub},
      # Start Finch
      {Finch, name: DedGrimory.Finch},
      # Start the Endpoint (http/https)
      DedGrimoryWeb.Endpoint
      # Start a worker by calling: DedGrimory.Worker.start_link(arg)
      # {DedGrimory.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DedGrimory.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DedGrimoryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
