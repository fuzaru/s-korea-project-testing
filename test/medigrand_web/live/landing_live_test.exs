defmodule MedigrandWeb.LandingLiveTest do
  use MedigrandWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders landing page with Korean default locale", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")

    assert html =~ "지금 예약하기"
    assert html =~ "?lang=en"
  end

  test "uses lang query param and persists locale in session", %{conn: conn} do
    conn = get(conn, ~p"/?lang=en")

    assert get_session(conn, :locale) == "en"
    assert html_response(conn, 200) =~ "Book Appointment Now"

    conn = get(recycle(conn), ~p"/")

    assert html_response(conn, 200) =~ "Book Appointment Now"
  end
end
