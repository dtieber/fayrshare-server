defmodule Repositories.ExpenseGroupRepositoryInMemory do
  def all(_) do
    [
      %ExpenseGroup{id: 1, name: "Expense Group One"},
      %ExpenseGroup{id: 2, name: "Expense Group Two"}
    ]
  end
end
