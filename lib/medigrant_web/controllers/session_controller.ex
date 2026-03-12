defmodule MedigrantWeb.SessionController do
  use MedigrantWeb, :controller

  alias Medigrant.Accounts

  def create(conn, %{"login" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_patient(email, password) do
      {:ok, patient} ->
        conn
        |> put_session(:patient_id, patient.id)
        |> put_flash(:info, gettext("Logged in successfully."))
        |> redirect(to: ~p"/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, gettext("Invalid email or password."))
        |> redirect(to: ~p"/login")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: ~p"/")
  end
end
