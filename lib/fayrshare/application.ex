defmodule Fayrshare.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = Application.get_env(:fayrshare, :environment) |> children()

    opts = [strategy: :one_for_one, name: Fayrshare.Supervisor]

    Logger.info("The server has started on port: #{port()}...")

    Supervisor.start_link(children, opts)
  end

  defp children(:test) do
    [
      {Plug.Cowboy, scheme: :http, plug: Fayrshare.Router, options: [port: port()]}
    ]
  end

  defp children(_) do
    children(:test) ++ [Repositories.ExpenseGroupRepository]
  end

  defp port, do: Application.get_env(:fayrshare, :port, 8000)
end
