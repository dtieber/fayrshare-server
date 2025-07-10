defmodule Services.ExpenseGroupService do
  def list_expense_groups do
    expense_groups = Repositories.ExpenseGroupRepository.all(ExpenseGroup)
    {:ok, expense_groups}
  end

  def get_expense_group_by_id(id) when is_integer(id) do
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

  def update_expense_group(id, data) when is_integer(id) do
    data_id = Map.get(data, :id) || Map.get(data, "id")

    if data_id != id do
      {:invalid, "Id has to match id in body"}
    else
      update_existing_expense_group(id, data)
    end
  end

  defp update_existing_expense_group(id, data) do
    case Repositories.ExpenseGroupRepository.get(ExpenseGroup, id) do
      nil ->
        {:not_found, "Expense group not found"}

      expense_group ->
        expense_group
        |> ExpenseGroup.changeset(data)
        |> Repositories.ExpenseGroupRepository.update()
        |> handle_update_result()
    end
  end

  defp handle_update_result({:ok, updated}), do: {:ok, updated}

  defp handle_update_result({:error, _}), do: {:invalid, "Invalid data"}
end
