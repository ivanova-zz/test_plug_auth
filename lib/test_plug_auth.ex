defmodule TestPlugAuth do
  import Plug.Conn
  import TestPlugAuth.TokenHelper
  import TestPlugAuth.Config
  import TestPlugAuth.User

  defmacro __using__(options) do
    IO.puts("options in using: #{inspect options}")
    behaviour = get_module(Keyword.get(options, :module))
    quote do
      alias unquote(behaviour), as: Mod
#      def init(options) do
#        options
#      end
      def call(conn, options) do
        user_id = conn.body_params[options[:key]]
        token = get_token(conn.req_headers)
        IO.puts("authorization: #{inspect token}")
        IO.puts("test_check_user: #{inspect Mod.get_user_id(user_id)}")
        IO.puts("options_call: #{inspect options}")
        secret_key = get_secret_key
        IO.puts("secret_key: #{inspect secret_key}")
        {:ok, jwt_body} = verify_jwt(token, secret_key, Keyword.get(options, :aud), Keyword.get(options, :iss))
        IO.puts("verify_jwt: #{inspect jwt_body}}")
        {:ok, sub} = Map.fetch(jwt_body, "sub")
        answer = validate_user_id(user_id, sub, Mod.get_user_id(user_id))
        IO.puts("validate_user: #{inspect answer}")
        if {:ok, :authorized} == answer do
          conn
        else
          conn |> resp(401, "unauthorized") |> halt()
        end
      end

      def generate_token(conn, options) do
        IO.puts("options_call: #{inspect options}")
        user_id = conn.body_params[options[:key]]
        token = generate_jwt!(Mod.get_user_id(user_id), get_secret_key, Keyword.get(options, :aud), Keyword.get(options, :iss), Keyword.get(options, :role))
        IO.puts("token: #{inspect token}")
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
