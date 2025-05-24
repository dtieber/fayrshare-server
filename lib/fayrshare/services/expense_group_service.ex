defmodule Services.ExpenseGroupService do
  def get_all_expense_groups do
    expense_groups = [
      %{id: 1, name: "Expense Group One"}
    ]

    {:ok, expense_groups}
  end
end
