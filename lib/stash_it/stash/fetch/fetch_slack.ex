defmodule StashIt.Stash.Fetch.FetchSlack do
  use Slack

  def get_members(token) do
    Slack.Web.Users.list(%{token: token})
    |> Map.get("members")
    |> Enum.map(fn(member) ->
      %{"id" => member["id"], "name" => member["real_name"]}
    end)
  end

  def list_attachment(token, channel_id) do
    Slack.Web.Channels.history(channel_id, %{token: token, count: 1000})
    |> Map.get("messages")
  end

  def list_channels(token) do
    Slack.Web.Channels.list(%{token: token})
    |> Map.get("channels")
    |> Enum.map(fn(channel) ->
       %{name: channel["name"], id: channel["id"]}
    end)
  end

end
