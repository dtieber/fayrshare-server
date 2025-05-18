defmodule RestApiTest.Router do
  use ExUnit.Case, async: true
  import Plug.Test

  @opts Fayrshare.Router.init([])

  test "index route returns valid json" do
    conn = conn(:get, "/")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert Jason.decode(conn.resp_body) == {:ok, %{"hello" => "fayrshare"}}
  end
end
