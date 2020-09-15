defmodule StashIt.Web.SlackEventController do
  use StashIt.Web, :controller
  require Logger

  #challenge
  def event(conn, %{"challenge" => challenge, "token" => token, "type" => "url_verification"} = _params) do
    real_token = Application.get_env(:ueberauth, Ueberauth.Strategy.Slack.OAuth)[:token]
    case token do
      real_token ->
        conn
        |> assign(:challenge, challenge)
        |> render("challenge.txt")
      _ ->
        #do something if wrong token
    end
  end

  def event(conn, params) do
    Logger.debug ""
    Logger.debug "Var value: #{inspect(params)}"
    Logger.debug ""
  end
end
