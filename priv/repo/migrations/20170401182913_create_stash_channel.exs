defmodule StashIt.Repo.Migrations.CreateStashIt.Stash.Channel do
  use Ecto.Migration

  def change do
    create table(:stash_channels) do
      add :team_id, references(:stash_teams, on_delete: :nothing)
      add :name, :string
      add :provider_id, :string
      timestamps()
    end
    create index(:stash_channels, [:provider_id, :name])
  end
end
