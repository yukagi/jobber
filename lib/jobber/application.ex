defmodule Jobber.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    job_runner_config = [
      strategy: :one_for_one,
      name: Jobber.JobRunner,
      max_seconds: 30
    ]

    children = [
      {Registry, keys: :unique, name: Jobber.JobRegistry},
      {DynamicSupervisor, job_runner_config}
      # Starts a worker by calling: Jobber.Worker.start_link(arg)
      # {Jobber.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jobber.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
