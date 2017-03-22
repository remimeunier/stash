defmodule StashIt.Web.StashedController do
  use StashIt.Web, :controller
  alias StashIt.Accounts.User

  alias StashIt.Stash
  import StashIt.Accounts
  import Guardian.Plug
  import StashIt.Stash.Fetch.FetchSlack

  #plug :authorize_resource, model: User, id_name: "user_id", persisted: true, only: :index, unauthorized_handler: {StashIt.HandleUnauthorized, :unauthorized}

  def index(conn, %{"channel_id" => channel_id} = params) do
  	user = @current_user
  	channel_id = params["channel_id"]
    conn
    |> assign(:names, get_members)
    |> assign(:messages, list_attachment(channel_id))
    |> assign(:user, user)
    |> assign(:list_channels, list_channels )
    |> render("index.html")
	end

  def index(conn, params) do
    user = @current_user
    conn
    |> assign(:names, get_members)
    |> assign(:messages, nil)
    |> assign(:user, user)
    |> assign(:list_channels, list_channels )
    |> render("index.html")
  end

end
