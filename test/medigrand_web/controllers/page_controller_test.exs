defmodule MedigrandWeb.PageControllerTest do
  use MedigrandWeb.ConnCase, async: true

  test "GET / renders the landing liveview", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Medigrand"
  end
end
