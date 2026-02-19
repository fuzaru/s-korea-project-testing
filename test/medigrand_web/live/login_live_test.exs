defmodule MedigrandWeb.LoginLiveTest do
  use MedigrandWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders login page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/login")

    assert html =~ "Welcome Back"
    assert html =~ "Log In"
  end
end
