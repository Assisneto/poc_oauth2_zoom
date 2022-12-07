defmodule AccessToken do
  use HTTPoison.Base

  @account_id "H1T7eOAfSvGqfHqhSHDkXA"
  @client_id "x0TXl8HUQDqCiAOlakGlqA"
  @client_secret "WftiC7xVLuqf1gy0K4Tuup3qN47WTgYb"

  def access_token(),
    do:
      request_access_token()
      |> body_parse()
      |> get_access_token()

  defp get_access_token({:ok, %{"access_token" => access_token}}), do: access_token
  defp get_access_token({:error, body}), do: {:error, body}

  defp request_access_token(),
    do:
      post!(
        "https://zoom.us/oauth/token",
        "",
        [
          {"Authorization", "Basic #{base_encoder()}"}
        ],
        params: [
          {"grant_type", "account_credentials"},
          {"account_id", @account_id}
        ]
      )

  defp body_parse(%{status_code: 200, body: body}), do: Jason.decode(body)
  defp body_parse(%{status_code: _, body: body}), do: {:error, body}

  defp base_encoder(), do: Base.encode64("#{@client_id}:#{@client_secret}")
end
