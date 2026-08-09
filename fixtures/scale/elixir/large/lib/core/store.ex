defmodule Core.Store do
  alias Core.Config

  def save(%Config{results_path: path}, results) do
    File.write(path, Enum.map_join(results, "\n", & &1.subject))
  end

  def load(%Config{results_path: path}) do
    case File.read(path) do
      {:ok, body} -> String.split(body, "\n", trim: true)
      {:error, _reason} -> []
    end
  end

  def append(%Config{results_path: path}, entry) do
    File.write(path, entry <> "\n", [:append])
  end
end
