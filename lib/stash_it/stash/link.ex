defmodule StashIt.Stash.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stash_links" do
    belongs_to :team, StashIt.Stash.Team
    field :link, :string
    field :link_message, :string
    field :link_service_name, :string
    field :text_message, :string
    field :time_stamp, :naive_datetime
    belongs_to :poster, StashIt.Stash.User
    belongs_to :channel, StashIt.Stash.Channel
    timestamps()
  end

  def link_changeset(link, attrs) do
    link
    |> cast(attrs, [:team_id, :link, :link_message, :link_service_name, :text_message, :time_stamp, :poster_id, :channel_id])
    |> validate_required([:poster_id, :channel_id, :link])
  end
end
