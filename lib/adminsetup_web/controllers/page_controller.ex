defmodule AdminsetupWeb.PageController do
  use AdminsetupWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
