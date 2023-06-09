defmodule Exmeal.Github.ClientTest do
  use ExUnit.Case, async: true

  alias Exmeal.Error
  alias Exmeal.Github.Client

  describe "get_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "where there is a valid username, returns the repos", %{bypass: bypass} do
      username = "dhh"

      url = endpoint_url(bypass.port)

      body = File.read!("test/fixtures/repos.json")

      Bypass.expect(bypass, "GET", "#{username}/repos/", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      reponse = Client.get_repos(url, username)

      expected_response =
        {:ok,
         [
           %{
             description: "Rails plugin for picking a non-ssl asset host as often as possible",
             html_url: "https://github.com/dhh/asset-hosting-with-minimum-ssl",
             id: 81_754,
             name: "asset-hosting-with-minimum-ssl",
             stargazers_count: 79
           },
           %{
             description: nil,
             html_url: "https://github.com/dhh/conductor",
             id: 79_943,
             name: "conductor",
             stargazers_count: 65
           },
           %{
             description: "My stripped down Rails bundle for TextMate 2",
             html_url: "https://github.com/dhh/textmate-rails-bundle",
             id: 147_432_708,
             name: "textmate-rails-bundle",
             stargazers_count: 36
           }
         ]}

      assert expected_response == reponse
    end

    test "when there is a invalid user name, returns an error", %{bypass: bypass} do
      user_name = "invalid_user"

      url = endpoint_url(bypass.port)

      body = ~s({"message": "Not Found"})

      Bypass.expect(bypass, "GET", "#{user_name}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(404, body)
      end)

      response = Client.get_repos(url, user_name)

      expected_response = {:error, Error.build(:not_found, "User not found!")}

      assert expected_response == response
    end

    test "when timeout occurs, returns an error", %{bypass: bypass} do
      user_name = "dhh"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_repos(url, user_name)

      expected_response =
        {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert expected_response == response
    end

    def endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
