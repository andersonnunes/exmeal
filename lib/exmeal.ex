defmodule Exmeal do
  alias Exmeal.Meals.Create
  alias Exmeal.Meals.Delete
  alias Exmeal.Meals.Get
  alias Exmeal.Meals.Update

  defdelegate create_meal(params), to: Create, as: :call
  defdelegate delete_meal(id), to: Delete, as: :call
  defdelegate get_meal_by_id(id), to: Get, as: :call
  defdelegate update_meal(params), to: Update, as: :call
end
