defmodule StashIt.Web.PageController do
  use StashIt.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
