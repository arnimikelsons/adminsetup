defmodule Adminsetup.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Adminsetup.Repo,
      # Start the Telemetry supervisor
      AdminsetupWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Adminsetup.PubSub},
      # Start the Endpoint (http/https)
      AdminsetupWeb.Endpoint
      # Start a worker by calling: Adminsetup.Worker.start_link(arg)
      # {Adminsetup.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Adminsetup.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AdminsetupWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
