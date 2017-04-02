defmodule StashIt.Stash.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stash_channels" do
    belongs_to :team, StashIt.Stash.Team
    field :name, :string
    field :provider_id, :string
    timestamps()
  end

  def channel_changeset(channel, attrs) do
    channel
    |> cast(attrs, [:team_id, :name, :provider_id])
    |> validate_required([:team_id, :provider_id])
  end

end
