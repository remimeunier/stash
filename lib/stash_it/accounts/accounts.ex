defmodule StashIt.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Ecto.{Query, Changeset}, warn: false
  alias StashIt.Repo
  alias StashIt.Accounts.User

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

   def change_user(%User{} = user) do
     User.registration_changeset(user, %{})
   end

   def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
   end

  def login_by_email_and_pass(conn, email, given_pass) do
    user = Repo.get_by(User, email: email)
    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end

  # def change_user(%User{} = user) do
  #   user_changeset(user, %{})
  # end

  #def list_users do
     #Repo.all(User)
  # end

  # def update_user(%User{} = user, attrs) do
  #   user
  #   |> user_changeset(attrs)
  #   |> Repo.update()
  # end

  # def delete_user(%User{} = user) do
  #   Repo.delete(user)
  # end

  # def change_user(%User{} = user) do
  #   user_changeset(user, %{})
  # end

end
