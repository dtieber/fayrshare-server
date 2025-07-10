defmodule Services.ExpenseGroupService do
  def add_expense_group(data) do
    changeset = ExpenseGroup.changeset(%ExpenseGroup{}, data)

    case changeset.valid? do
      false ->
        {:invalid, "Invalid data"}

      true ->
        response = get_repository().insert(changeset)
        response
    end
  end

  def get_all_expense_groups do
    expense_groups = get_repository().all(ExpenseGroup)
    {:ok, expense_groups}
  end

  defp get_repository do
    Application.get_env(:fayrshare, :expense_group_repository)
  end
end
