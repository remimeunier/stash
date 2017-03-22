defmodule StashIt.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset, warn: false
  schema "accounts_users" do
    field :email, :string
    field :is_admin, :boolean, default: false
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many :teams, StashIt.Stash.Team

    timestamps()
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password_hash, :is_admin])
    |> validate_required([:email])
  end
end
