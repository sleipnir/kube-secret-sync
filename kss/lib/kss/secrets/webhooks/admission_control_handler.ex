defmodule Kss.Secrets.Webhooks.AdmissionControlHandler do
  @moduledoc """
  Admission Webhook Handler for KSS
  """
  use K8sWebhoox.AdmissionControl.Handler

  import K8sWebhoox.AdmissionControl.AdmissionReview

  validate "apps/v1/deployment", conn do
    # TODO
  end
end
