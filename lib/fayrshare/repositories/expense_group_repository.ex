defmodule Repositories.ExpenseGroupRepository do
  use Ecto.Repo,
    otp_app: :fayrshare,
    adapter: Ecto.Adapters.Postgres
end
