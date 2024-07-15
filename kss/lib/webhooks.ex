defmodule KSS.Webhooks do
  @moduledoc """
  """
  require Logger

  alias KSS.K8sConn

  @spec bootstrap_tls(atom(), binary()) :: :ok
  def bootstrap_tls(env, secret_name) do
    Application.ensure_all_started(:k8s)
    conn = K8sConn.get!(env)

    with {:certs, {:ok, ca_bundle}} <-
           {:certs, K8sWebhoox.ensure_certificates(conn, "kss", "kss", "kss", secret_name)},
         {:webhook_config, :ok} <-
           {:webhook_config, K8sWebhoox.update_admission_webhook_configs(conn, "kss", ca_bundle)} do
      Logger.info("TLS Bootstrap completed.")
    else
      error ->
        Logger.error("TLS Bootstrap failed: #{inspect(error)}")
        exit({:shutdown, 1})
    end
  end
end
