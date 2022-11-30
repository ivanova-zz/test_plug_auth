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
    IO.puts("start USING")
#    @behaviour Guardian
    quote bind_quoted: [options: options] do
      use Guardian.Plug.Pipeline, otp_app: unquote(Keyword.get(options, :otp_app)),
                                  module: unquote(Keyword.get(options, :module)),
                                  error_handler: unquote(Keyword.get(options, :error_handler))

      use Guardian.Plug.VerifyHeader, realm: unquote(Keyword.get(options, :realm))
      use Guardian.Plug.EnsureAuthenticated
      use Guardian.Plug.LoadResource

      use GuardianOtp, otp_app: unquote(Keyword.get(options, :otp_app)), account: unquote(Keyword.get(options, :account))
      def get_conf2 do
        "conf2: #{inspect unquote(Keyword.get(options, :module)).config()}"
      end
      def get_conf1 do
        "conf1: #{inspect GuardianOtp.config()}"
      end
      IO.puts("conf1: #{inspect GuardianOtp.config()}")
      IO.puts("conf2: #{inspect unquote(Keyword.get(options, :module)).config()}")
    end
    IO.puts("end USING")
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
    IO.puts("start call")
    user = Guardian.Plug.current_resource(conn)
    IO.puts("user: #{inspect user}")
#    IO.puts("#{inspect get_conf1}")
#    IO.puts("#{inspect get_conf2}")
#    IO.puts("conf: #{inspect GuardianOtp.config()}")
    if conn.body_params["author"] == user.id do
      conn
    else
      #      {:invalid_payload, %BadTokenException{}}
      conn |> Plug.Conn.put_flash(:error, conn.body_params["author"])
    end
#    answer = Map.new(conn.body_params)
#    conn |> Plug.Conn.put_flash(401, Guardian.config())
#    options |> Map.new |> IO.puts
#    IO.puts(Application.get_env(options[:otp_app], __MODULE__, []))
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
