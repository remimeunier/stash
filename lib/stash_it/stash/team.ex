defmodule StashIt.Stash.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stash_teams" do
    field :provider, :integer
    field :token, :string
    field :valide, :boolean
    field :name, :string
    belongs_to :user, StashIt.Accounts.User
    has_many :members, StashIt.Stash.User, on_delete: :delete_all
    has_many :channels, StashIt.Stash.Channel, on_delete: :delete_all

    timestamps()
  end

  def change_team(team) do
    team_changeset(team, %{})
  end

  def team_changeset(team, attrs) do
    team
    |> cast(attrs, [:token, :provider, :user_id, :valide, :name])
    |> validate_required([:token, :provider, :name])
  end
end
