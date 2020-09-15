defmodule StashIt.Stash.Fetch.InitSlack do
 alias StashIt.Stash.Fetch.FetchSlack
 alias StashIt.Stash
 require Logger

 def init(team) do
  init_members(team)
  init_channels(Stash.get_members(team), team)
 end

 def init_members(team) do
    Slack.Web.Users.list(%{token: team.token})
    |> Map.get("members")
    |> Enum.each(fn(member) ->
      Stash.create_member(%{team_id: team.id, name: member["name"], real_name: member["real_name"], provider_id: member["id"]})
    end)
 end

  defp init_channels(members, team) do
    Slack.Web.Channels.list(%{token: team.token})
    |> Map.get("channels")
    |> Enum.each(fn(channel) ->
      case Stash.create_channel(%{team_id: team.id, name: channel["name"], provider_id: channel["id"]}) do
        {:ok, channel_object} ->
          init_links(members, team, channel_object)
        {:error, _} ->
          #TODO hundle error
      end
    end)
  end

  #TODO refactor next fonctions
  defp init_links(members, team, channel, oldest) do
    new_fonction(Slack.Web.Channels.history(channel.provider_id, %{token: team.token, count: 1000, latest: oldest}), members, team, channel)
  end

  defp init_links(members, team, channel) do
    new_fonction(Slack.Web.Channels.history(channel.provider_id, %{token: team.token, count: 1000}), members, team, channel)
  end

  defp new_fonction(%{"has_more" => true } = json, members, team, channel) do
    json
    |> Map.get("messages")
    |> Enum.each(&get_link(&1, members, team, channel))

    test = json
    |> Map.get("messages")

    oldest = Enum.at(test, -1)
    |> Map.get("ts")
    init_links(members, team, channel, oldest)
  end

  defp new_fonction(%{"has_more" => false } = json, members, team, channel) do
    json
    |> Map.get("messages")
    |> Enum.each(&get_link(&1, members, team, channel))
  end

  #TODO choose between 'text' Or 'Title' in attachment
  defp get_link(%{"user" => user_slack_id, "text" => message_text, "ts" => time_stamp, "attachments" => [%{"from_url" => url, "title" => attachment_text , "service_name" => service_name}, ]} = mess, members, team, channel) do
    #%{ name: b, url: a, service: c, poster: d}
     Stash.create_link(%{link: url,
                        link_message: attachment_text,
                        link_service_name: service_name,
                        text_message: message_text,
                        time_stamp: time_stamp |> Integer.parse |> elem(0) |> Ecto.DateTime.from_unix!(:seconds) |> Ecto.DateTime.to_erl |> NaiveDateTime.from_erl!,
                        poster_id: Enum.filter_map(members, fn(x) -> x.provider_id == user_slack_id end, &(&1.id)) |> Enum.at(0), #Stash.get_member(team, user_slack_id).id,
                        channel_id: channel.id })
  end

  #Maybe TO DO handle one arg missing
  defp get_link(_a, _b, _c, _d) do
  end
end
