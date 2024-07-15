defmodule Kss.Webhooks.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward("/kss", to: Kss.Secrets.Webhooks.Router)
end
