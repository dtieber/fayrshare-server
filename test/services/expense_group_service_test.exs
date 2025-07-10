defmodule Repositories.ExpenseGroupServiceTest do
  use RepoCase

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repositories.ExpenseGroupRepository)
  end

  test "returns list of expense groups" do
    {:ok, %ExpenseGroup{id: id1}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Expense Group One"})

    {:ok, %ExpenseGroup{id: id2}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Expense Group Two"})

    {:ok, expense_groups} =
      Services.ExpenseGroupService.get_all_expense_groups()

    simplified = Enum.map(expense_groups, fn eg -> %{id: eg.id, name: eg.name} end)

    assert simplified == [
             %{id: id1, name: "Expense Group One"},
             %{id: id2, name: "Expense Group Two"}
           ]
  end

  test "returns an expense group by id" do
    {:ok, %ExpenseGroup{id: id}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Test Expense Group"})

    {:ok, expense_group} = Services.ExpenseGroupService.get_expense_group_by_id(id)

    assert expense_group.id == id
  end

  test "returns :not_found when expense group cannot be found by id" do
    assert {:not_found, _} = Services.ExpenseGroupService.get_expense_group_by_id(1)
  end

  test "adds an expense group" do
    {:ok, %ExpenseGroup{id: id, name: name}} =
      Services.ExpenseGroupService.add_expense_group(%{name: "Test Expense Group"})

    assert id != nil
    assert name == "Test Expense Group"
  end

  test "does not add an invalid expense group" do
    assert {:invalid, _} =
             Services.ExpenseGroupService.add_expense_group(%{invalid: "invalid"})
  end
end
