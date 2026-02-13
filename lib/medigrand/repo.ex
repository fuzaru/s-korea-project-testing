defmodule Medigrand.Repo do
  use Ecto.Repo,
    otp_app: :medigrand,
    adapter: Ecto.Adapters.Postgres
end
