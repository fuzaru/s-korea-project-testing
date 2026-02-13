defmodule Medigrand.SeeYouDocClient do
  @moduledoc """
  Behaviour for external telemedicine API adapters.
  """

  @callback list_doctors() :: {:ok, list(map())} | {:error, term()}
  @callback get_doctor(String.t()) :: {:ok, map()} | {:error, term()}
  @callback create_booking(map()) :: {:ok, map()} | {:error, term()}
  @callback get_booking(String.t()) :: {:ok, map()} | {:error, term()}
  @callback authenticate(map()) :: {:ok, map()} | {:error, term()}
end
