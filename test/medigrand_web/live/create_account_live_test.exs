defmodule MedigrandWeb.CreateAccountLiveTest do
  @moduledoc """
  This module tests the CreateAccountLive live view, which is responsible for rendering the create account page and handling user interactions related to account creation.
  """
  use MedigrandWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders create account page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/create-account")

    assert html =~ "계정 만들기"
    assert html =~ "이미 계정이 있으신가요?"
  end
end
