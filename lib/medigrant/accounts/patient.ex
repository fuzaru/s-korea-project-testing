defmodule Medigrant.Accounts.Patient do
  @moduledoc """
  User schema.
  It includes fields for email, name, and password hash.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :name, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :country_code, :string
    field :mobile_number, :string
    field :date_of_birth, :date
    field :sex, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :country_code,
      :mobile_number,
      :date_of_birth,
      :sex,
      :password
    ])
    |> validate_required([
      :email,
      :first_name,
      :last_name,
      :country_code,
      :mobile_number,
      :date_of_birth,
      :sex,
      :password
    ])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/)
    |> validate_inclusion(:sex, ["female", "male", "other"])
    |> put_name()
    |> put_password_hash()
    |> unique_constraint(:email)
  end

  defp put_name(changeset) do
    first = get_field(changeset, :first_name)
    last = get_field(changeset, :last_name)

    if is_binary(first) and is_binary(last) do
      put_change(changeset, :name, String.trim("#{first} #{last}"))
    else
      changeset
    end
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, password)
    end
  end
end
