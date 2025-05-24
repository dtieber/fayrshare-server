defmodule RestApiTest.Router do
  use ExUnit.Case, async: true
  import Plug.Test

  @opts Fayrshare.Router.init([])

  test "/expense-groups returns list of expense-groups" do
    conn = conn(:get, "/expense-groups")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert Jason.decode(conn.resp_body) ==
             {:ok,
              [
                %{"id" => 1, "name" => "Expense Group One"},
                %{"id" => 2, "name" => "Expense Group Two"}
              ]}
  end

  test "invalid route returns 404" do
    conn = conn(:get, "/invalid")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end
