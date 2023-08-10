defmodule DedGrimory.Repo do
  use Ecto.Repo,
    otp_app: :ded_grimory,
    adapter: Ecto.Adapters.Postgres
end
