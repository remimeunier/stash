defmodule StashIt.Web.TeamController do
  use StashIt.Web, :controller

  alias StashIt.Stash
  alias StashIt.Stash.Team
  import StashIt.Accounts
  import Guardian.Plug
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  # def request(conn, _params) do
  #   render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  # end

  def index(conn, params) do
    conn
    |> assign(:teams, Stash.list_teams(current_resource(conn).id))
    |> render("index.html")
  end

  def new(conn, _params) do
    changeset = Team.change_team(%StashIt.Stash.Team{})
    render(conn, "new.html", changeset: changeset, callback_url: Helpers.callback_url(conn))
  end

  def create(conn, %{"team" => team_params}) do
    case Stash.create_team(Map.put(team_params, "user_id", current_resource(conn).id)) do
      {:ok, team} ->
        Stash.Fetch.InitSlack.init(team)
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: team_path(conn, :show, team))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign(:test, changeset)
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Stash.get_team!(id)
    render(conn, "show.html", team: team)
  end

  def edit(conn, %{"id" => id}) do
    team = Stash.get_team!(id)
    changeset = Team.change_team(team)
    render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Stash.get_team!(id)

    case Stash.update_team(team, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: team_path(conn, :show, team))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Stash.get_team!(id)
    {:ok, _team} = Stash.delete_team(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: team_path(conn, :index))
  end
end
