defmodule StashIt.Web.Router do
  use StashIt.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :login_required do
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
      resources "/teams", TeamController
      get "/stashed", StashedController, :index
      get "/stashed/:id", StashedController, :get
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", StashIt.Web do
  #   pipe_through :api
  # end
end
