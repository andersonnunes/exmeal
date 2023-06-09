defmodule ExmealWeb.MealsJSON do
  alias Exmeal.Meal

  def create(%{meal: %Meal{} = meal}) do
    %{
      meals: %{
        meal: meal
      },
      message: "Meal created!"
    }
  end

  def show(%{meal: %Meal{} = meal}), do: %{meal: meal}
end
