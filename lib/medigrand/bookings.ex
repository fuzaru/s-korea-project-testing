defmodule Medigrand.Bookings do
  @moduledoc """
  Bookings context for appointment workflows.
  """

  @client Application.compile_env(:medigrand, :see_you_doc_client, Medigrand.SeeYouDocHTTP)

  @spec create_booking(map()) :: {:ok, map()} | {:error, term()}
  def create_booking(params) when is_map(params) do
    @client.create_booking(params)
  end

  @spec get_booking(String.t()) :: {:ok, map()} | {:error, term()}
  def get_booking(booking_id) when is_binary(booking_id) do
    @client.get_booking(booking_id)
  end
end
