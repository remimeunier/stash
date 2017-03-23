defmodule StashIt.Stash do
  @moduledoc """
  The boundary for the Stash system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias StashIt.Repo

  alias StashIt.Stash.Team

  def list_teams(user_id) do
  Repo.all from t in Team,
         join: user in assoc(t, :user),
         where: user.id == ^user_id
  end

  def list_teams do
    Repo.all(Team)
  end

  def get_team!(id), do: Repo.get!(Team, id)

  def create_team(attrs \\ %{}) do
    %Team{}
    |> team_changeset(attrs)
    |> Repo.insert()
  end

  def update_team(%Team{} = team, attrs) do
    team
    |> team_changeset(attrs)
    |> Repo.update()
  end

  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  def change_team(%Team{} = team) do
    team_changeset(team, %{})
  end

  defp team_changeset(%Team{} = team, attrs) do
    team
    |> cast(attrs, [:token, :provider, :user_id, :valide, :name])
    |> validate_required([:token, :provider, :name])
  end
end
