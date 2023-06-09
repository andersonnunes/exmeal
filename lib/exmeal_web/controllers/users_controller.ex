defmodule ExmealWeb.UsersController do
  use ExmealWeb, :controller

  alias Exmeal.User

  action_fallback ExmealWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Exmeal.create_user(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Exmeal.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Exmeal.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Exmeal.update_user(params) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end
end
