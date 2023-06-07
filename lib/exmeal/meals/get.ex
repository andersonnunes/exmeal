defmodule Exmeal.Meals.Get do
  alias Exmeal.{Error, Meal, Repo}

  def call(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_meal_not_found()}
      meal -> {:ok, meal}
    end
  end
end
