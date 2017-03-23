defmodule StashIt.Stash.Team do
  use Ecto.Schema

  schema "stash_teams" do
    field :provider, :integer
    field :token, :string
    #field :user_id, :id
    field :valide, :boolean
    field :name, :string
    belongs_to :user, StashIt.Accounts.User

    timestamps()
  end
end
