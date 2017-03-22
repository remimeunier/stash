defmodule StashIt.Web.StashedView do
  use StashIt.Web, :view

  def generate_raws(links) do
  	Enum.map(links, &get_attachments(&1))
	end

	def name_from_id(id, names) do
		[a | b ] = Enum.filter(names, fn (x) -> x["id"] == id end)
		a["name"]
	end

  defp get_attachments(%{"user" => d, "attachments" => [%{"from_url" => a, "title" => b, "service_name" => c}, ]} = mess) do
    #Enum.map(@names, &get_attachments(&1))
    %{ name: b, url: a, service: c, poster: d}
  end

  defp get_attachments(a), do: nil


end
