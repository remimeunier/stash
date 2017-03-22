defmodule StashIt.Accounts.HandleUnauthorized do

  import StashIt.Web.Router.Helpers
  import Plug.Conn

  def unauthorized(conn) do
    conn
    |> Phoenix.Controller.put_flash(:info, "You’re not autorized")
    |> Phoenix.Controller.redirect(to: page_path(conn, :index))
  end

end
