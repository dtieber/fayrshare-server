defmodule Fayrshare.Router do
  use Plug.Router

  alias Services.ExpenseGroupService

  plug(Plug.Logger)

  plug(:match)
  plug(:dispatch)

  match "/expense-groups", via: :get do
    response = ExpenseGroupService.get_all_expense_groups()
    response |> handle_response(conn)
  end

  match _ do
    response = {:not_found, %{error: "Route is not mapped"}}
    response |> handle_response(conn)
  end

  defp handle_response(response, conn) do
    %{code: code, payload: payload} =
      case response do
        {:ok, payload} -> %{code: 200, payload: payload}
        {:not_found, payload} -> %{code: 404, payload: %{error: "Not found: #{payload.error}"}}
        {:error, _} -> %{code: 500, payload: %{error: "An error occurred"}}
      end

    send_resp(conn |> put_resp_content_type("application/json"), code, Jason.encode!(payload))
  end
end
