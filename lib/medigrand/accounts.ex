defmodule Medigrand.Accounts do
  @moduledoc """
  Accounts context for authentication and patient identity orchestration.
  """

  @client Application.compile_env(:medigrand, :see_you_doc_client, Medigrand.SeeYouDocHTTP)

  @spec authenticate(map()) :: {:ok, map()} | {:error, term()}
  def authenticate(credentials) when is_map(credentials) do
    @client.authenticate(credentials)
  end
end
