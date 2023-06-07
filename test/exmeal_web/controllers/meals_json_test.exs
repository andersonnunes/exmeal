defmodule ExmealWeb.MealsJSONTest do
  use ExmealWeb.ConnCase, async: true

  alias Exmeal.Meal

  alias ExmealWeb.MealsJSON

  test "render create.json" do
    params = %{description: "Banana", date: "2001-05-02", calories: "20"}
    {_ok, meal} = Exmeal.create_meal(params)

    response = MealsJSON.create(%{meal: meal})

    assert %{
             meal: %Meal{
               calories: 20,
               date: ~D[2001-05-02],
               description: "Banana",
               id: _id
             },
             message: "Meal created!"
           } = response
  end

  test "render meal.json" do
    params = %{description: "Banana", date: "2001-05-02", calories: "20"}
    {_ok, meal} = Exmeal.create_meal(params)

    response = MealsJSON.show(%{meal: meal})

    assert %{
             meal: %Meal{
               calories: 20,
               date: ~D[2001-05-02],
               description: "Banana",
               id: _id
             }
           } = response
  end
end
