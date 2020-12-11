defmodule FutureMadeEvents.Repo do
  use Ecto.Repo,
    otp_app: :csv_mania,
    adapter: Ecto.Adapters.Postgres
end
