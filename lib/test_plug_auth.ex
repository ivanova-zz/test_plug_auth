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
  defmacro __using__ (options) do
    quote bind_quoted: [options: options] do
      @behaviour Guardian
      use Guardian.Plug.Pipeline, otp_app: options[:otp_app],
                                  module: options[:module],
                                  error_handler: options[:error_handler]

      plug Guardian.Plug.VerifyHeader, realm: options[:realm]
      plug Guardian.Plug.EnsureAuthenticated
      plug Guardian.Plug.LoadResource
    end
  end
  def init(options) do
#    @behaviour Guardian
#    use Guardian.Plug.Pipeline, otp_app: options[:otp_app],
#                                module: options[:module],
#                                error_handler: options[:error_handler]
#
#    plug Guardian.Plug.VerifyHeader, realm: options[:realm]
#    plug Guardian.Plug.EnsureAuthenticated
#    plug Guardian.Plug.LoadResource
    options
  end

  def call(conn, _options) do
    conn
  end
end
