defmodule StashIt.Web.UserController do
  use StashIt.Web, :controller

  alias StashIt.Accounts.User
  alias StashIt.Accounts

  plug :authorize_resource, model: User, only: :show, unauthorized_handler: {StashIt.Accounts.HandleUnauthorized, :unauthorized}

  def new(conn, _params) do
    changeset = Accounts.change_user(%StashIt.Accounts.User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> StashIt.Accounts.login(user)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  # def index(conn, _params) do
  #   users = Accounts.list_users()
  #   render(conn, "index.html", users: users)
  # end

  # def edit(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   changeset = Accounts.change_user(user)
  #   render(conn, "edit.html", user: user, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Accounts.get_user!(id)

  #   case Accounts.update_user(user, user_params) do
  #     {:ok, user} ->
  #       conn
  #       |> put_flash(:info, "User updated successfully.")
  #       |> redirect(to: user_path(conn, :show, user))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", user: user, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   {:ok, _user} = Accounts.delete_user(user)

  #   conn
  #   |> put_flash(:info, "User deleted successfully.")
  #   |> redirect(to: user_path(conn, :index))
  # end
end
