defmodule StashIt.Web.UserView do
  use StashIt.Web, :view


  import Plug.Conn
  import Guardian.Plug

  def test(conn) do
		current_resource(conn)
  end
end
