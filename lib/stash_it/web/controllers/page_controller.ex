defmodule StashIt.Web.PageController do
  use StashIt.Web, :controller
  import Guardian.Plug
  alias StashIt.Stash
  plug Guardian.Plug.EnsureAuthenticated, handler: StashIt.Web.PageController

  def index(conn, _params) do
    u = current_resource(conn)
    if u == nil do
      # not conected
      render conn, "index.html"
    else
      teams = Stash.list_teams(u.id)
      if Enum.empty?(teams) do
        # no teams, have to create one
        redirect conn, to: "/auth/slack"
      else
        # one team detect fo to stash controller
        id = Enum.at(teams, 0).id
        redirect conn, to: "/team/#{id}"
      end
    end
  end

  def unauthenticated(conn, _params) do
    # welcome page
    render conn, "index.html"
  end
end
