defmodule Medigrant.Accounts.Doctor do
  @moduledoc """
  Doctor schema.
  It includes fields for name, email, and license number.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "doctors" do
    field :name, :string
    field :email, :string
    field :license_number, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(doctor, attrs) do
    doctor
    |> cast(attrs, [:name, :email, :license_number, :password_hash])
    |> validate_required([:name, :email, :license_number, :password_hash])
    |> unique_constraint([:email, :license_number, :password_hash])
  end
end
