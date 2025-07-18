defmodule RestApiTest.Router do
  use RepoCase, async: true
  import Plug.Test

  @opts Fayrshare.Router.init([])

  test "GET /expense-groups returns list of expense groups" do
    {:ok, %ExpenseGroup{id: id1}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Expense Group One"})

    {:ok, %ExpenseGroup{id: id2}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Expense Group Two"})

    conn = conn(:get, "/expense-groups")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert Jason.decode(conn.resp_body) ==
             {:ok,
              [
                %{"id" => id1, "name" => "Expense Group One"},
                %{"id" => id2, "name" => "Expense Group Two"}
              ]}
  end

  test "GET /expense-groups/:id returns expense group" do
    {:ok, %ExpenseGroup{id: id1}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Expense Group One"})

    conn = conn(:get, "/expense-groups/#{id1}")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert Jason.decode(conn.resp_body) ==
             {:ok, %{"id" => id1, "name" => "Expense Group One"}}
  end

  test "POST /expense-groups creates new expense group" do
    conn = conn(:post, "/expense-groups", %{name: "My Expense Group"})

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    {:ok, response} = Jason.decode(conn.resp_body)
    assert response["name"] == "My Expense Group"
  end

  test "PUT /expense-groups/:id updates an expense group" do
    {:ok, %ExpenseGroup{id: id1}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Expense Group One"})

    conn = conn(:put, "/expense-groups/#{id1}", %{id: id1, name: "My Updated Expense Group"})

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    {:ok, response} = Jason.decode(conn.resp_body)
    assert response["name"] == "My Updated Expense Group"
  end

  test "invalid route returns 404" do
    conn = conn(:get, "/invalid")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end
