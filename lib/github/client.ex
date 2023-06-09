defmodule Exmeal.Github.Client do
  use Tesla

  alias Exmeal.Error
  alias Tesla.Env

  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  @base_url "https://api.github.com/users"

  def get_repos(url \\ @base_url, username) do
    "#{url}/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    user_info =
      body
      |> Enum.map(fn %{
                       "id" => id,
                       "name" => name,
                       "description" => description,
                       "html_url" => html_url,
                       "stargazers_count" => stargazers_count
                     } ->
        %{
          id: id,
          name: name,
          description: description,
          html_url: html_url,
          stargazers_count: stargazers_count
        }
      end)

    {:ok, user_info}
  end

  defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
    {:error, Error.build(:not_found, "User not found!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
