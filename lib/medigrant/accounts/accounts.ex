defmodule Medigrant.Accounts do
  @moduledoc """
  Accounts context for authentication and patient identity orchestration.
  """
  import Ecto.Query, warn: false
  alias Medigrant.Repo

  alias Medigrant.Accounts.{Doctor, Patient}

  def create_patient(attrs) do
    Patient
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_patient(email, password) do
    Patient
    |> where([p], p.email == ^email)
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      patient ->
        if check_user_password(patient, password) do
          {:ok, patient}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  defp check_user_password(patient, password) do
    patient.password_hash == password
  end

  def create_doctor(attrs) do
    Doctor
    |> Doctor.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_doctor(email, license_number, password) do
    Doctor
    |> where([e, d], e.email == ^email and d.license_number == ^license_number)
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      doctor ->
        if check_doctor_password(doctor, password) do
          {:ok, doctor}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  defp check_doctor_password(doctor, password) do
    doctor.password_hash == password
  end
end

#   @client Application.compile_env(:medigrant, :see_you_doc_client, Medigrant.SeeYouDocHTTP)

#   @spec authenticate(map()) :: {:ok, map()} | {:error, term()}
#   def authenticate(credentials) when is_map(credentials) do
#     @client.authenticate(credentials)
#   end
# end
