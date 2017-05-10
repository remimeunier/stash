defmodule StashIt.Web.Router do
  use StashIt.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug StashIt.Accounts.CurrentUser
  end

  pipeline :login_required do
    plug StashIt.Accounts.CurrentUser
    plug Guardian.Plug.EnsureAuthenticated, handler: StashIt.Accounts.GuardianErrorHandler
  end

  pipeline :admin_required do
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug StashIt.Accounts.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StashIt.Web do
    pipe_through [:browser, :with_session] # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    scope "/" do
      pipe_through [:login_required]
      resources "/users", UserController, only: [:show]
      #resources "/teams", TeamController

      get "/auth/:provider", AuthController, :request
      get "/auth/:provider/callback", AuthController, :callback
      resources "/teams", TeamController, except: [:show] do
        get "/channel/:channel_id", StashedController, :get_from_channel
        get "/user/:user_id", StashedController, :get_from_user
      end
      get "/team/:team_id", StashedController, :all_from_team
      # resources "/teams", TeamController
      # get "/team/:team_id/channel/:channel_id", StashedController, :get_from_channem
      # get "/team/:team_id/user/:user_id", StashedController, :get_from_channem

       # get "/stashed", StashedController, :index
       # get "/stashed/:id", StashedController, :get
       # get "/stashed/:id/channel/:channel_id", StashedController, :get_via_channel
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", StashIt.Web do
  #   pipe_through :api
  # end
end
