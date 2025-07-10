defmodule ExpenseGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name]}

  schema "expense_groups" do
    field :name, :string
  end

  def changeset(expense_group, params \\ %{}) do
    expense_group
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
