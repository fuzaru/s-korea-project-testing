defmodule MedigrandWeb.CreateAccountLiveTest do
  use MedigrandWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders create account page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/create-account")

    assert html =~ "계정 만들기"
    assert html =~ "이미 계정이 있으신가요?"
  end
end
