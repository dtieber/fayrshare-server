defmodule RestApiTest.Router do
  use RepoCase, async: true
  import Plug.Test

  @opts Fayrshare.Router.init([])

  test "/expense-groups returns list of expense-groups" do
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

  test "invalid route returns 404" do
    conn = conn(:get, "/invalid")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end
