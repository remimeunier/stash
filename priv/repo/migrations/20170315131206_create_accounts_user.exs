defmodule StashIt.Repo.Migrations.CreateStashIt.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:accounts_users, [:email])
  end
end
