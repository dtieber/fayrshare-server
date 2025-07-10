defmodule Fayrshare.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Fayrshare.Router, options: [port: port()]},
      Repositories.ExpenseGroupRepository
    ]

    opts = [strategy: :one_for_one, name: Fayrshare.Supervisor]

    Logger.info("The server has started on port: #{port()}...")

    Supervisor.start_link(children, opts)
  end

  defp port, do: Application.get_env(:fayrshare, :port, 8000)
end
