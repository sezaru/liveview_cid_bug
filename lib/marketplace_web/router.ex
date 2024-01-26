defmodule MarketplaceWeb.Router do
  use MarketplaceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MarketplaceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", MarketplaceWeb.Admin.Disposition do
    pipe_through :browser

    live "/", ListLive, :index
  end
end
