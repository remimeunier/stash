defmodule StashIt.Web.SessionController do
  use StashIt.Web, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias StashIt.Accounts.User

  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do

    case StashIt.Accounts.Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You’re now signed in!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
     end
  end

  def delete(conn, _) do
    conn
    |> StashIt.Accounts.Auth.logout
    |> put_flash(:info, "See you later!")
    |> redirect(to: page_path(conn, :index))
  end

end
