defmodule ExpenseGroup do
  use Ecto.Schema

  @derive {Jason.Encoder, except: [:__meta__, :__struct__]}

  schema "expense_groups" do
    field :name, :string
  end
end
