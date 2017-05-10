defmodule StashIt.Repo.Migrations.CreateStashIt.Stash.Team do
  use Ecto.Migration

  def change do
    create table(:stash_teams) do
      add :token, :string
      add :provider, :integer
      add :user_id, references(:accounts_users, on_delete: :nothing)
      add :valide, :boolean
      add :name, :string
      add :provider_team_id, :string
      add :provider_user_id, :string

      timestamps()
    end

    create index(:stash_teams, [:user_id])
  end
end
