defmodule Greenbar.Markdown do

  @on_load {:init, 0}

  app = Mix.Project.config[:app]

  def init do
    path = :filename.join(:code.priv_dir(unquote(app)), 'greenbar_markdown')
    :ok = :erlang.load_nif(path, 0)
  end

  def analyze(text) do
    case parse(text) do
      {:ok, []} ->
        {:ok, []}
      {:ok, values} ->
        {:ok, Enum.reverse(values)}
      error ->
        error
    end
  end

  @spec parse(text :: String.t) :: {:ok, []|[map()]}
  def parse(text)

  def parse(_text), do: exit(:nif_library_not_loaded)
end
