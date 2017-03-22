defmodule StashIt.Stash.Fetch.FetchSlack do
  use Slack

  @token "xoxp-113405365253-145470925124-154035612406-2e857adb9cfe885ec5ac49f8421cf405"
  def get_members do
    Slack.Web.Users.list(%{token: @token})
    |> Map.get("members")
    |> Enum.map(fn(member) ->
      %{"id" => member["id"], "name" => member["real_name"]}
    end)
  end

  def list_attachment(channel_id) do
    Slack.Web.Channels.history(channel_id, %{token: @token, count: 1000})
    |> Map.get("messages")
  end

  def list_channels do
    Slack.Web.Channels.list(%{token: @token})
    |> Map.get("channels")
    |> Enum.map(fn(channel) ->
       %{name: channel["name"], id: channel["id"]}
    end)
  end


end
