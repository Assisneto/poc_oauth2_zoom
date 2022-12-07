defmodule Users do
  alias AccessToken
  use HTTPoison.Base

  def my_user() do
    HTTPoison.get!("https://api.zoom.us/v2/users/me", [
      {"Authorization", "Bearer #{AccessToken.access_token()}"}
    ])
    |> body_parse()
  end

  defp body_parse(%{status_code: 200, body: body}), do: Jason.decode(body)
  defp body_parse(%{status_code: _, body: body}), do: {:error, body}
end
