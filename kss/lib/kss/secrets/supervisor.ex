defmodule Kss.Secrets.Supervisor do
  @moduledoc """
  Supervisor for the Secret manager.
  """
  use Supervisor

  alias Kss.Secrets.Operator

  @spec start_link(Keyword.t()) :: Supervisor.on_start()
  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(operator_args: args) do
    children = [
      {Operator, Keyword.put(args, :name, Operator)}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
