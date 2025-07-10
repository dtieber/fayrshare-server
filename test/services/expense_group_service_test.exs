defmodule Repositories.ExpenseGroupServiceTest do
  use RepoCase

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repositories.ExpenseGroupRepository)
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
