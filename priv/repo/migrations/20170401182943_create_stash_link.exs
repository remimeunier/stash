defmodule StashIt.Repo.Migrations.CreateStashIt.Stash.Link do
  use Ecto.Migration

  def change do
    create table(:stash_links) do
      add :team_id, references(:stash_teams, on_delete: :nothing)
      add :link, :string
      add :link_message, :string
      add :link_service_name, :string
      add :text_message, :string
      add :time_stamp, :naive_datetime
      add :poster_id, references(:stash_users, on_delete: :nothing)
      add :channel_id, references(:stash_channels, on_delete: :nothing)
      timestamps()
    end
  create index(:stash_links, [:team_id, :poster_id, :channel_id, :time_stamp])
  end
end
