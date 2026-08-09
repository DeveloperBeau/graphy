defmodule Core.Session do
  alias Core.Config

  defstruct done: 0, config: nil

  def begin, do: %__MODULE__{config: Config.defaults()}

  def step(session), do: %{session | done: session.done + 1}
end
