defmodule StashIt.Web.PageController do
  use StashIt.Web, :controller
  import Guardian.Plug
  alias StashIt.Stash
  plug Guardian.Plug.EnsureAuthenticated, handler: StashIt.Web.PageController

  def index(conn, _params) do
    teams = Stash.list_teams(current_resource(conn).id)
    if teams == nil do
      #no teams, have to create one
      redirect conn, to: "/teams/new"
    else
      #one team detect fo to stash controller
      id = Enum.at(teams, 0).id
      redirect conn, to: "/team/#{id}"
    end
  end

  def unauthenticated(conn, _params) do
    #welcome page
    render conn, "index.html"
  end
end
