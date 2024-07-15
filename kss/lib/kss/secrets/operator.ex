defmodule Kss.Secrets.Operator do
  @moduledoc """
  This operator handles resources regarding secret managers configuration.
  """

  use Bonny.Operator, default_watch_namespace: :all

  alias Kompost.Kompo.Postgres.Controller
  alias Kss.Secrets.Versions.V1alpha1

  step(Bonny.Pluggable.Logger, level: :info)
  step(:delegate_to_controller)
  step(Bonny.Pluggable.ApplyStatus)
  step(Bonny.Pluggable.ApplyDescendants)

  @impl Bonny.Operator
  def controllers(watching_namespace, _opts) do
    [
      %{
        query:
          K8s.Client.watch("kss.io/v1alpha1", "SecretManager", namespace: watching_namespace),
        controller: Controller.InstanceController
      }
    ]
  end

  @impl Bonny.Operator
  def crds() do
    [
      %Bonny.API.CRD{
        group: "kss.io",
        scope: :Namespaced,
        names: Bonny.API.CRD.kind_to_names("SecretManager", ["sctm", "sm"]),
        versions: [V1Alpha1.SecretManager]
      }
    ]
  end
end
