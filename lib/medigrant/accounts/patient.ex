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
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end
end
