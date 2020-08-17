defmodule RumblWeb.Auth do
  import Phoenix.Controller
  import Plug.Conn
  
  alias RumblWeb.Router.Helpers, as: Routes

  @moduledoc """
  Handles authentication for protected routes
  """
  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Rumbl.Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end


  @doc """
  Authentication plug
  """
  def authenticate_user(conn, _options) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You need to be logged in to access that page!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
