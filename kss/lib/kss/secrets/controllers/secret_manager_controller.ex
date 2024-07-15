defmodule Kss.Secrets.Controllers.SecretManagerController do
  @moduledoc """
  Controller for the Secret Manager.
  """
  use Bonny.ControllerV2
  require Logger

  alias Kss.Pluggable.InitConditions

  step(Bonny.Pluggable.SkipObservedGenerations)
  step(Kss.Pluggable.InitConditions, conditions: ["Connection"])
  step(:handle_event)

  @impl true
  def rbac_rules() do
    [to_rbac_rule({"", "secrets", ["*"]})]
  end

  @spec handle_event(Bonny.Axn.t(), Keyword.t()) :: Bonny.Axn.t()
  def handle_event(%Bonny.Axn{action: action} = axn, _opts)
      when action in [:add, :modify, :reconcile] do
    with :ok do
      success_event(axn)
    else
      _ ->
        message = ""
        Logger.warning("#{axn.action} failed. #{message}")

        axn
        |> failure_event(message: message)
        |> set_condition("Connection", false, message)
    end
  end

  def handle_event(%Bonny.Axn{action: :delete} = axn, _opts) do
    success_event(axn)
  end
end
