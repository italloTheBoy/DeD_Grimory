defmodule DedGrimoryWeb.Router do
  use DedGrimoryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DedGrimoryWeb do
    pipe_through :api

    get "/magics", MagicController, :index
    get "/magic/id/:id", MagicController, :show
    get "/magic/name/:name", MagicController, :show
    resources "/magic", MagicController, except: [:index]
  end
end
