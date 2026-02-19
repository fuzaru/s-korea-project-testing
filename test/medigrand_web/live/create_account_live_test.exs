defmodule MedigrandWeb.CreateAccountLiveTest do
  use MedigrandWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders create account page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/create-account")

    assert html =~ "Create Account"
    assert html =~ "Already have an account?"
  end
end
