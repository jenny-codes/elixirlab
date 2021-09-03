defmodule ElixirLab.Web.PageController do
  use ElixirLab.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
