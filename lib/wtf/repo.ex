defmodule Wtf.Repo do
  use Ecto.Repo,
    otp_app: :wtf,
    adapter: Ecto.Adapters.Postgres
end
