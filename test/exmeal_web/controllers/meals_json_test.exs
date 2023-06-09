defmodule ExmealWeb.MealsJSONTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Meal, User}

  alias ExmealWeb.MealsJSON

  test "render create.json" do
    user_params = build(:users_params)

    {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

    params = build(:meals_params, %{user_id: user_id})
    {:ok, %Meal{id: id} = meal} = Exmeal.create_meal(params)

    response = MealsJSON.create(%{meal: meal})

    assert %{
             meals: %{
               meal: %Meal{
                 calories: 20,
                 date: ~D[2001-05-02],
                 description: "Banana",
                 id: ^id,
                 user_id: ^user_id
               }
             },
             message: "Meal created!"
           } = response
  end

  test "render meal.json" do
    user_params = build(:users_params)

    {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

    params = build(:meals_params, %{user_id: user_id})
    {:ok, %Meal{id: id} = meal} = Exmeal.create_meal(params)

    response = MealsJSON.show(%{meal: meal})

    assert %{
             meal: %Meal{
               calories: 20,
               date: ~D[2001-05-02],
               description: "Banana",
               id: ^id,
               user_id: ^user_id
             }
           } = response
  end
end
