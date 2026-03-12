defmodule MedigrantWeb.HealthControllerTest do
  use MedigrantWeb.ConnCase, async: true

  test "GET /health", %{conn: conn} do
    conn = get(conn, ~p"/health")
    assert response(conn, 200) == "ok"
  end
end
