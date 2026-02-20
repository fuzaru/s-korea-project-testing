defmodule MedigrandWeb.DoctorsLiveTest do
  @moduledoc """
  Tests for the DoctorsLive directory page.
  """
  use MedigrandWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders doctors page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/doctors")

    assert html =~ "의료진 만나기"
    assert html =~ "전문의"
    assert html =~ "진료 예약"
  end
end
