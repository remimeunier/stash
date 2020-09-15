defmodule StashIt.Web.StashedView do
  use StashIt.Web, :view

  def display_time(timestamp) do
    timestamp
    |> Integer.parse
    |> DateTime.from_unix!
  end

end
