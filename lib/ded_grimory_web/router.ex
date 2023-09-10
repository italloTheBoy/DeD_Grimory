defmodule DedGrimoryWeb.Router do
  use DedGrimoryWeb, :router

  @resources_opts [except: [:index, :new, :edit]]

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DedGrimoryWeb do
    pipe_through :api

    get "/magics", MagicController, :index
    get "/magic/id/:id", MagicController, :show
    get "/magic/name/:name", MagicController, :show
    resources "/magic", MagicController, @resources_opts

    get "/books", BookController, :index
    get "/book/id/:id", BookController, :show
    get "/book/name/:name", BookController, :show
    resources "/book", BookController, @resources_opts
  end
end
