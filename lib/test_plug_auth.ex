defmodule TestPlugAuth do
  @moduledoc """
  Documentation for `TestPlugAuth`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TestPlugAuth.hello()
      :world

  """
  def init(options) do
    options
  end

  def call(conn, _options) do
    conn
  end
end
