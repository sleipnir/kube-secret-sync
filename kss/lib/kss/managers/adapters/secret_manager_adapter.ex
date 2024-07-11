defprotocol Kss.Managers.Adapters.SecretManagerAdapter do
  @moduledoc """

  """

  @spec init(struct(), opts \\ []) :: any()
  def init(adapter, opts)
end
