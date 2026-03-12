defmodule MedigrantWeb.Live.AuthHook do
  @moduledoc """
  LiveView on_mount hook to set logged-in state from session.
  """
  import Phoenix.Component

  def on_mount(:default, _params, session, socket) do
    patient_id = session["patient_id"] || session[:patient_id]
    {:cont, assign(socket, :logged_in, not is_nil(patient_id))}
  end
end
