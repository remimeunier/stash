defmodule StashIt.Web.StashedController do
  use StashIt.Web, :controller

  alias StashIt.Stash
  import StashIt.Accounts
  import Guardian.Plug
  alias StashIt.Stash.Fetch.FetchSlack

  #plug :authorize_resource, model: User, id_name: "user_id", persisted: true, only: :index, unauthorized_handler: {StashIt.HandleUnauthorized, :unauthorized}


  def all_from_team(conn, %{"team_id" => team_id} = params) do
    team = Stash.get_team!(team_id)
    conn
    |> assign(:teams, Stash.list_teams(current_resource(conn).id))
    |> assign(:team_id, team.id)
    |> assign(:channel_id, nil)
    |> assign(:user_id, nil)
    |> assign(:names, Stash.get_members(team))
    |> assign(:list_of_links, Stash.get_links_from_team(team.id))
    |> assign(:list_channels, Stash.get_channels(team) )
    |> render("show.html")
  end


  def get_from_channel(conn, %{"team_id" => team_id, "channel_id" => channel_id} = params) do
    team = Stash.get_team!(team_id)
    conn
    |> assign(:teams, Stash.list_teams(current_resource(conn).id))
    |> assign(:team_id, team.id)
    |> assign(:channel_id, String.to_integer(channel_id))
    |> assign(:user_id, nil)
    |> assign(:names, Stash.get_members(team))
    |> assign(:list_of_links, Stash.get_links_from_channel(channel_id))
    |> assign(:list_channels, Stash.get_channels(team) )
    |> render("show.html")
	end

  def get_from_user(conn, %{"team_id" => team_id, "user_id" => user_id} = params) do
    team = Stash.get_team!(team_id)
    conn
    |> assign(:teams, Stash.list_teams(current_resource(conn).id))
    |> assign(:team_id, team.id)
    |> assign(:channel_id, nil)
    |> assign(:user_id, String.to_integer(user_id))
    |> assign(:names, Stash.get_members(team))
    |> assign(:list_of_links, Stash.get_links_from_user(user_id))
    |> assign(:list_channels, Stash.get_channels(team) )
    |> render("show.html")
  end

  # def get(conn, %{"id" => team_id} = params) do
  #   team = Stash.get_team!(team_id)

  #   conn
  #   |> assign(:team_id, team.id)
  #   |> assign(:names, Stash.get_members(team))
  #   |> assign(:messages, nil)
  #   |> assign(:list_of_links, nil)
  #   |> assign(:list_channels, Stash.get_channels(team))
  #   |> render("show.html")
  # end

  # def show(conn, %{"id" => id}) do
    # team = Stash.get_team!(id)
    # render(conn, "show.html")
  # end

end
