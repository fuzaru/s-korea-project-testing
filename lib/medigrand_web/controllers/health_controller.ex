defmodule MedigrandWeb.HealthController do
  use MedigrandWeb, :controller

  def index(conn, _params) do
    text(conn, "ok")
  end
end
