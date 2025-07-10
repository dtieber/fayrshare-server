defmodule Services.ExpenseGroupService do
  def list_expense_groups do
    expense_groups = Repositories.ExpenseGroupRepository.all(ExpenseGroup)
    {:ok, expense_groups}
  end

  def get_expense_group_by_id(id) do
    expense_group = ExpenseGroup |> Repositories.ExpenseGroupRepository.get(id)

    case expense_group do
      nil -> {:not_found, "Could not find expense group with id ${id}"}
      _ -> {:ok, expense_group}
    end
  end

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
end
