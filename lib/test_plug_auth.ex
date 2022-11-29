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
  defmacro __using__ (options \\ []) do
#    @behaviour Guardian
    quote bind_quoted: [options: options] do
      use Guardian.Plug.Pipeline, otp_app: options[:otp_app],
                                  module: options[:module],
                                  error_handler: options[:error_handler]

      plug Guardian.Plug.VerifyHeader, realm: options[:realm]
      plug Guardian.Plug.EnsureAuthenticated
      plug Guardian.Plug.LoadResource
      use Guardian, otp_app: options[:otp_app]

      def subject_for_token(user, _claims) do
        sub = to_string(user.id)
        {:ok, sub}
      end

      def subject_for_token(_, _) do
        {:error, :reason_for_error}
      end

      def resource_from_claims(claims) do
        id = claims["sub"]
        resource = unquote(options[:account]).get_user!(id)
        {:ok,  resource}
      end

      def resource_from_claims(_claims) do
        {:error, :reason_for_error}
      end
    end
    IO.puts("USING")
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
#    quote bind_quoted: [options: options] do
#      @behaviour Guardian
#      use Guardian.Plug.Pipeline, otp_app: options[:otp_app],
#                                  module: options[:module],
#                                  error_handler: options[:error_handler]
#
#      plug Guardian.Plug.VerifyHeader, realm: options[:realm]
#      plug Guardian.Plug.EnsureAuthenticated
#      plug Guardian.Plug.LoadResource
#    end

#    user = Guardian.Plug.current_resource(conn)
#    if conn.body_params["author"] == user.id do
#      conn
#    else
#      #      {:invalid_payload, %BadTokenException{}}
#      conn |> Plug.Conn.put_flash(:error, conn.body_params["author"])
#    end
#    answer = Map.new(conn.body_params)
#    conn |> Plug.Conn.put_flash(401, Guardian.config())
    IO.puts(Application.get_env(options[:otp_app], __MODULE__, []))
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
