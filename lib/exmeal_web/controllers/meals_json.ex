defmodule ExmealWeb.MealsJSON do
  alias Exmeal.Meal

  def create(%{meal: %Meal{} = meal}) do
    %{
      message: "Meal created!",
      meal: meal
    }
  end

  def show(%{meal: %Meal{} = meal}), do: %{meal: meal}
end
