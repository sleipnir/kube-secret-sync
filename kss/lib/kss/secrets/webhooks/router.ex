defmodule Kss.Secrets.Webhooks.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  post("/admission-review/validating",
    to: K8sWebhoox.Plug,
    init_opts: [
      webhook_handler: {Kss.Secrets.Webhooks.AdmissionControlHandler, webhook_type: :validating}
    ]
  )
end
