defmodule StashIt.Stash.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stash_users" do
    belongs_to :team, StashIt.Stash.Team
    field :name, :string
    field :real_name, :string
    field :provider_id, :string
    timestamps()
  end

  def user_changeset(user, attrs) do
    user
    |> cast(attrs, [:team_id, :name, :real_name, :provider_id])
    |> validate_required([:team_id])
  end
end
