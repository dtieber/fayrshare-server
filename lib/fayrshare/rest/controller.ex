defmodule Fayrshare.Rest.Controller do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  match "/", via: :get do
    send_resp(conn |> put_resp_content_type("application/json"), 200, Jason.encode!(%{hello: "fayrshare"}))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
