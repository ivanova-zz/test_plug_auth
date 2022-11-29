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

  def call(conn, options) do
    user = Guardian.Plug.current_resource(conn)
    if options[:user_id] == user.id do
      conn
    else
      #      {:invalid_payload, %BadTokenException{}}
      conn |> resp(401, "unauthorized")
    end
  end

#  def validate_user_id(conn, user_id) do
#    user = Guardian.Plug.current_resource(conn)
#    if user_id == user.id do
#      conn
#    else
##      {:invalid_payload, %BadTokenException{}}
#      conn
#      |> put_flash(:error, "You need to sign in or sign up before continuing.")
#      |> halt()
#    end
#  end
end
