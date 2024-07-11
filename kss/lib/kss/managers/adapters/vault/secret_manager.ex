defmodule Kss.Managers.Adapters.Vault.SecretManager do
  @moduledoc """

  """
  @auth_module Vault.Auth.UserPass

  @type t() :: %__MODULE__{}
  defstruct []

  defimpl Kss.Managers.Adapters.SecretManagerAdapter,
    for: Kss.Managers.Adapters.Vault.SecretManager do
    @impl true
    def init(_adapter, opts) do
      auth_module = Keyword.get(opts, :auth_mod, @auth_module)

      {:ok, vault} =
        Vault.new(
          auth: auth_module
          engine: Vault.Engine.KVV2,
        )
        |> do_login(opts)

      :persistent_term.put({__MODULE__, :vault}, vault)
    end

    defp do_login(vault, opts) do
      case Keyword.get(opts, :auth_mod, @auth_module) do
        @auth_module ->
          do_login(vault, :user_passwd, opts)

        method ->
          raise ArgumentError, "Invalid authentication method #{inspect(method)}"
      end
    end

    defp do_login(vault, :user_passwd, opts) do
      creds = %{username: Keyword.fetch!(opts, :user), password: Keyword.fetch!(opts, :passwd)}
      Vault.auth(vault, creds)
    end
  end
end
