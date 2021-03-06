defmodule StashIt.Stash do

  import Ecto.{Query, Changeset}, warn: false
  alias StashIt.Repo
  alias StashIt.Stash.Team
  alias StashIt.Stash.User
  alias StashIt.Stash.Channel
  alias StashIt.Stash.Link
  require Logger

  ############ teams ############
  def list_teams(user_id) do
    Repo.all from t in Team,
           join: user in assoc(t, :user),
           where: user.id == ^user_id
  end

  def get_team!(id), do: Repo.get!(Team, id)

  def create_team(attrs \\ %{}) do
    Logger.debug "Var value: #{inspect(attrs)}"
    %Team{}
    |> Team.team_changeset(attrs)
    |> Repo.insert()
  end

  # def update_team(%Team{} = team, attrs) do
  #   team
  #   |> Team.team_changeset(attrs)
  #   |> Repo.update()
  # end

  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  ############ members ############
  def create_member(attrs \\ %{}) do
    %User{}
    |> User.user_changeset(attrs)
    |> Repo.insert()
  end

  def get_members(team) do
    Ecto.assoc(team, :members)
    |> Repo.all
  end

  def get_member(team, provider_id) do
    Repo.get_by(User, team_id: team.id, provider_id: provider_id)
  end
    ############ Channels ############

  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.channel_changeset(attrs)
    |> Repo.insert()
  end

  def get_channels(team) do
    Ecto.assoc(team, :channels)
    |> Repo.all
  end

  ############ Links ############

  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.link_changeset(attrs)
    |> Repo.insert()
  end

  def get_links_from_channel(channel_id) do
    Repo.all from link in Link,
      join: channel in assoc(link, :channel),
      where: channel.id == ^channel_id,
      #order_by: [desc: link.created_at],
      preload: [:poster, channel: channel]
  end

  def get_links_from_team(team_id) do
    Repo.all from link in Link,
      join: channel in assoc(link, :channel),
      where: channel.team_id == ^team_id,
      #order_by: [desc: link.created_at],
      preload: [:poster, channel: channel]
  end

  def get_links_from_user(user_id) do
    Repo.all from link in Link,
      join: user in assoc(link, :poster),
      where: user.id == ^user_id,
      #order_by: [desc: link.created_at],
      preload: [:channel, poster: user]
  end

 # def get_channels(team) do
 #   Ecto.assoc(team, :channels)
 #   |> Repo.all
 # end

end
