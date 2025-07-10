defmodule RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Repositories.ExpenseGroupRepository

      import Ecto
      import Ecto.Query
      import RepoCase
    end
  end

  setup tags do
    pid =
      Ecto.Adapters.SQL.Sandbox.start_owner!(Repositories.ExpenseGroupRepository,
        shared: not tags[:async]
      )

    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end
end
