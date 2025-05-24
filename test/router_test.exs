defmodule RestApiTest.Router do
  use ExUnit.Case, async: true
  import Plug.Test

  @opts Fayrshare.Router.init([])

  test "invalid route returns 404" do
    conn = conn(:get, "/invalid")

    conn = Fayrshare.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end
