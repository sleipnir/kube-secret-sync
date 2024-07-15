defmodule KSS.Application do
  @moduledoc false
  use Application

  @spec bandit(atom()) :: {module(), keyword()}
  defp bandit(:prod) do
    {Bandit,
     plug: Kss.Webhooks.Router,
     port: 8090,
     certfile: "/mnt/cert/tls.crt",
     keyfile: "/mnt/cert/tls.key",
     scheme: :https}
  end

  defp bandit(_) do
    {Bandit, plug: Kss.Webhooks.Router, port: 8090, scheme: :http}
  end

  @impl true
  def start(_type, env: env) do
    children = [
      bandit(env)
    ]

    opts = [strategy: :one_for_one, name: KSS.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
