defmodule StashIt.Web.StashedController do
  use StashIt.Web, :controller
  alias StashIt.Accounts.User

  alias StashIt.Stash
  import StashIt.Accounts
  import Guardian.Plug
  import StashIt.Stash.Fetch.FetchSlack

  #plug :authorize_resource, model: User, id_name: "user_id", persisted: true, only: :index, unauthorized_handler: {StashIt.HandleUnauthorized, :unauthorized}

  def index(conn, params) do
    conn
    |> assign(:teams, Stash.list_teams(current_resource(conn).id))
    |> render("index.html")
  end


  def get(conn, %{"id" => team_id, "channel_id" => channel_id} = params) do
    team = Stash.get_team!(team_id)
  	channel_id = params["channel_id"]
    conn
    |> assign(:team_id, team.id)
    |> assign(:names, get_members(team.token))
    |> assign(:messages, list_attachment(team.token, channel_id))
    |> assign(:list_channels, list_channels(team.token) )
    |> render("show.html")
	end

  def get(conn, %{"id" => team_id} = params) do
    team = Stash.get_team!(team_id)
    conn
    |> assign(:team_id, team.id)
    |> assign(:names, get_members(team.token))
    |> assign(:messages, nil)
    |> assign(:list_channels, list_channels(team.token))
    |> render("show.html")
  end

  # def show(conn, %{"id" => id}) do
    # team = Stash.get_team!(id)
    # render(conn, "show.html")
  # end

end
