defmodule Medigrant.Repo do
  use Ecto.Repo,
    otp_app: :medigrant,
    adapter: Ecto.Adapters.Postgres
end
