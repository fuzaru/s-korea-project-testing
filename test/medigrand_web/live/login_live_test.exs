defmodule MedigrandWeb.LoginLiveTest do
  use MedigrandWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders login page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/login")

    assert html =~ "다시 오신 것을 환영합니다"
    assert html =~ "로그인"
    assert html =~ "계정 만들기"
  end
end
