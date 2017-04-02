defmodule StashIt.Repo.Migrations.CreateStashIt.Stash.User do
  use Ecto.Migration

  def change do
    create table(:stash_users) do
      add :team_id, references(:stash_teams, on_delete: :nothing)
      add :name, :string
      add :real_name, :string
      add :provider_id, :string
      timestamps()
    end
    create index(:stash_users, [:name, :real_name])
  end
end
