defmodule Exmeal.Github.Client do
  use Tesla

  alias Tesla.Env

  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]

  @base_url "https://api.github.com/users"

  def get_repos(username) do
    "#{@base_url}/#{username}/repos"
    |> get()
    |> handle_get()
  end

  def handle_get({:ok, %Env{status: 200, body: body}}) do
    user_info =
      body
      |> Jason.decode!()
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
end
