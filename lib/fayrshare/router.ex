defmodule Fayrshare.Router do
  use Plug.Router

  alias Services.ExpenseGroupService

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/expense-groups" do
    response = ExpenseGroupService.list_expense_groups()
    response |> handle_response(conn)
  end

  get "/expense-groups/:id" do
    case Integer.parse(conn.params["id"]) do
      {id, ""} ->
        response = ExpenseGroupService.get_expense_group_by_id(id)
        response |> handle_response(conn)

      _ ->
        {:invalid, "Id #{conn.params["id"]} is invalid"} |> handle_response(conn)
    end
  end

  post "/expense-groups" do
    response = ExpenseGroupService.add_expense_group(conn.body_params)
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
        {:invalid, payload} -> %{code: 400, payload: %{error: payload}}
        {:not_found, payload} -> %{code: 404, payload: %{error: "Not found: #{payload.error}"}}
        {:error, _} -> %{code: 500, payload: %{error: "An error occurred"}}
      end

    send_resp(conn |> put_resp_content_type("application/json"), code, Jason.encode!(payload))
  end
end
