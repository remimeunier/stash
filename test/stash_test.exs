defmodule StashIt.StashTest do
  use StashIt.DataCase

  alias StashIt.Stash
  alias StashIt.Stash.Team

  @create_attrs %{provider: 42, token: "some token"}
  @update_attrs %{provider: 43, token: "some updated token"}
  @invalid_attrs %{provider: nil, token: nil}

  def fixture(:team, attrs \\ @create_attrs) do
    {:ok, team} = Stash.create_team(attrs)
    team
  end

  test "list_teams/1 returns all teams" do
    team = fixture(:team)
    assert Stash.list_teams() == [team]
  end

  test "get_team! returns the team with given id" do
    team = fixture(:team)
    assert Stash.get_team!(team.id) == team
  end

  test "create_team/1 with valid data creates a team" do
    assert {:ok, %Team{} = team} = Stash.create_team(@create_attrs)
    assert team.provider == 42
    assert team.token == "some token"
  end

  test "create_team/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Stash.create_team(@invalid_attrs)
  end

  test "update_team/2 with valid data updates the team" do
    team = fixture(:team)
    assert {:ok, team} = Stash.update_team(team, @update_attrs)
    assert %Team{} = team
    assert team.provider == 43
    assert team.token == "some updated token"
  end

  test "update_team/2 with invalid data returns error changeset" do
    team = fixture(:team)
    assert {:error, %Ecto.Changeset{}} = Stash.update_team(team, @invalid_attrs)
    assert team == Stash.get_team!(team.id)
  end

  test "delete_team/1 deletes the team" do
    team = fixture(:team)
    assert {:ok, %Team{}} = Stash.delete_team(team)
    assert_raise Ecto.NoResultsError, fn -> Stash.get_team!(team.id) end
  end

  test "change_team/1 returns a team changeset" do
    team = fixture(:team)
    assert %Ecto.Changeset{} = Stash.change_team(team)
  end
end
