defmodule Repositories.ExpenseGroupRepositoryTest do
  use RepoCase

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repositories.ExpenseGroupRepository)
  end

  test "adds an expense group" do
    name = "Test Expense Group"
    changeset = ExpenseGroup.changeset(%ExpenseGroup{}, %{name: name})

    {:ok, %ExpenseGroup{name: inserted_name}} =
      Repositories.ExpenseGroupRepository.insert(changeset)

    assert inserted_name == name
  end
end
