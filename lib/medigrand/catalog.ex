defmodule Medigrand.Catalog do
  @moduledoc """
  Catalog context for doctor directory and availability metadata.
  """

  @client Application.compile_env(:medigrand, :see_you_doc_client, Medigrand.SeeYouDocHTTP)

  @spec list_doctors() :: {:ok, list(map())} | {:error, term()}
  def list_doctors do
    @client.list_doctors()
  end

  @spec get_doctor(String.t()) :: {:ok, map()} | {:error, term()}
  def get_doctor(doctor_id) when is_binary(doctor_id) do
    @client.get_doctor(doctor_id)
  end
end
