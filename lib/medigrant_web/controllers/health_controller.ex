defmodule MedigrantWeb.HealthController do
  use MedigrantWeb, :controller

  def index(conn, _params) do
    text(conn, "ok")
  end
end
