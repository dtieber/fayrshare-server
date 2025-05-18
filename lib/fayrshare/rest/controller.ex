defmodule Fayrshare.Rest.Controller do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  match "/", via: :get do
    send_resp(conn, 200, "Hello Fayrshare!")
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
