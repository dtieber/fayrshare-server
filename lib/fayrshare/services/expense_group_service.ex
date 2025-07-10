defmodule Services.ExpenseGroupService do
  def add_expense_group(data) do
    changeset = ExpenseGroup.changeset(%ExpenseGroup{}, data)

    case changeset.valid? do
      false ->
        {:invalid, "Invalid data"}

      true ->
        response = Repositories.ExpenseGroupRepository.insert(changeset)
        response
    end
  end

  def get_all_expense_groups do
    expense_groups = Repositories.ExpenseGroupRepository.all(ExpenseGroup)
    {:ok, expense_groups}
  end
end
