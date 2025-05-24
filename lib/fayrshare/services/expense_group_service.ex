defmodule Services.ExpenseGroupService do
  def get_all_expense_groups do
    get_repository().select_all_expense_groups()
  end

  defp get_repository do
    Application.get_env(:fayrshare, :expense_group_repository)
  end
end
