defmodule People.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "hello/:name", to: People.Hello
  get "goodbye/:name", to: People.Goodbye

  match _ do
    send_resp(conn, 404, "404, nothing to do here")
  end
end
