defmodule Services.ExpenseGroupService do
  def get_all_expense_groups do
    expense_groups = get_repository().all(ExpenseGroup)
    {:ok, expense_groups}
  end

  defp get_repository do
    Application.get_env(:fayrshare, :expense_group_repository)
  end
end
