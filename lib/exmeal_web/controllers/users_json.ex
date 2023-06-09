defmodule ExmealWeb.UsersJSON do
  alias Exmeal.User

  def create(%{user: %User{} = user}) do
    %{
      user: %{
        user: user
      },
      message: "User created!"
    }
  end

  def show(%{user: %User{} = user}), do: %{user: user}
end
