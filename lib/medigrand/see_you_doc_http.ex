defmodule Medigrand.SeeYouDocHTTP do
  @moduledoc """
  Stub HTTP adapter for SeeYouDoc-compatible APIs.

  Replace each function body with real `Req` calls when integration starts.
  """
  @behaviour Medigrand.SeeYouDocClient

  @impl true
  def list_doctors, do: {:ok, []}

  @impl true
  def get_doctor(_doctor_id), do: {:error, :not_implemented}

  @impl true
  def create_booking(_payload), do: {:error, :not_implemented}

  @impl true
  def get_booking(_booking_id), do: {:error, :not_implemented}

  @impl true
  def authenticate(_credentials), do: {:ok, %{token: "stub-token"}}
end
