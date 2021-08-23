defmodule Adminsetup.Repo do
  use Ecto.Repo,
    otp_app: :adminsetup,
    adapter: Ecto.Adapters.Postgres
end
