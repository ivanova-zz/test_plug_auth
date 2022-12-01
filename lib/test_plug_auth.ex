defmodule TestPlugAuth do
#  import Plug.Conn
  import TokenHelper
  import TestPlugAuth.Config

  defmacro __using__(options) do
    IO.puts("options in using: #{inspect options}")
    behaviour = get_module(Keyword.get(options, :module))
    quote do
      alias unquote(behaviour), as: Mod
      IO.puts("test_check_user: #{inspect Mod.get_user_id()}")
      def init(options) do
        options
      end
      def call(conn, options) do
        IO.puts("conn: #{inspect conn}")
        IO.puts("user_id: #{inspect conn.body_params[options[:key]]}")
        IO.puts("req_headers: #{inspect conn.req_headers}")
        auth = get_token(conn.req_headers)
        IO.puts("authorization: #{inspect auth}")
        IO.puts("test_check_user: #{inspect Mod.get_user_id()}")
        IO.puts("options_call: #{inspect options}")
        secret_key = get_secret_key
        IO.puts("secret_key: #{inspect secret_key}")
        IO.puts("verify_jwt: #{inspect verify_jwt(auth, secret_key)}}")
        conn
      end
    end
  end

#  def init(options) do
#    options
#  end
#  def call(conn, options) do
#    IO.puts("conn: #{inspect conn}")
#    IO.puts("user_id: #{inspect conn.body_params[options[:key]]}")
#    IO.puts("req_headers: #{inspect conn.req_headers}")
#    auth = get_token(conn.req_headers)
#    IO.puts("authorization: #{inspect auth}")
#    IO.puts("test_check_user: #{inspect User.check_user()}")
#    IO.puts("options_call: #{inspect options}")
#    conn
#  end

#  def check_user do
#    "test method in plug"
#  end
end
