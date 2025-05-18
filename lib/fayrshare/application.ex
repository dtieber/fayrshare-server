defmodule Fayrshare.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Fayrshare.Rest.Controller, options: [port: 3000]}
    ]

    opts = [strategy: :one_for_one, name: Fayrshare.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
