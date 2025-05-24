defmodule Repositories.ExpenseGroupRepositoryBehaviour do
  @callback select_all_expense_groups ::
              {:ok, [%ExpenseGroup{}]} | {:failure, reason :: String.t()}
end
