defmodule TestPlugAuth do
  import Plug.Conn
  def init(options) do
    IO.puts("options: #{inspect options}")
    options
  end
  def call(conn, _options) do
    IO.puts("options: #{inspect conn}")
    conn
  end
end
