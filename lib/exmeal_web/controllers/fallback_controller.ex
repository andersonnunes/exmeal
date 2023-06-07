defmodule ExmealWeb.FallbackController do
  use ExmealWeb, :controller

  alias Exmeal.Error
  alias ExmealWeb.ErrorJSON

  def call(conn, {:error, %Error{result: result, status: status}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorJSON)
    |> render("error.json", result: result)
  end
end
