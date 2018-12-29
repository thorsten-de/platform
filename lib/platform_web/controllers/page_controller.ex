defmodule PlatformWeb.PageController do
  use PlatformWeb, :controller

  plug :authenticate when action in [:index]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  defp authenticate(conn, _opts) do
    case conn.assigns.current_user do
      nil ->
        conn
        |> put_flash(:error, "Sie müssen angemeldet sein um diese Seite zu sehen")
        |> redirect(to: Routes.player_path(conn, :new))
        |> halt()

      _ ->
        conn
    end
  end
end
