defmodule StashIt.Web.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """
  require Logger
  import Guardian.Plug
  alias StashIt.Stash
  alias StashIt.Stash.Team

  use StashIt.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    conn
     |> assign(:message, fails)
     |> assign(:callback_url, Helpers.callback_url(conn))
     |> render("request.html")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Stash.create_team(%{user_id: current_resource(conn).id,
                             provider: 1,
                             name: auth.credentials.other.team,
                             provider_team_id: auth.credentials.other.team_id,
                             provider_user_id: auth.credentials.other.user_id,
                             token: auth.credentials.token}) do
      {:ok, team} ->
        Stash.Fetch.InitSlack.init(team)
        redirect conn, to: "/"
      {:error, %Ecto.Changeset{} = changeset} ->
        # TO DO error
    end
  end
end
