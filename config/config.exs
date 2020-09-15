# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :stash_it,
  ecto_repos: [StashIt.Repo]

# Configures the endpoint
config :stash_it, StashIt.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5SnmbagsWd/RJ+sIlyyTk05X5OeoD96YTUdLaKgDcGnr4Dn3UfwPkbXt5Xge/WUj",
  render_errors: [view: StashIt.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StashIt.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#guardian othentif
config :guardian, Guardian,
  issuer: "StashIt.#{Mix.env}",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  serializer: StashIt.Accounts.GuardianSerializer,
  secret_key: to_string(Mix.env) <> "SuPerseCret_aBraCadabrA"

#Oath
config :ueberauth, Ueberauth,
  providers: [
    slack: {Ueberauth.Strategy.Slack, [default_scope: "team:read,users:read,channels:history,identify,channels:read,links:read"]}
  ]

#canary
config :canary,
 repo: StashIt.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
