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
      def init(options) do
        options
      end
      def call(conn, options) do
        user_id = conn.body_params[options[:key]]
        IO.puts("user_id: #{inspect user_id}")
        IO.puts("req_headers: #{inspect conn.req_headers}")
        auth = get_token(conn.req_headers)
        IO.puts("authorization: #{inspect auth}")
        IO.puts("test_check_user: #{inspect Mod.get_user_id(user_id)}")
        IO.puts("options_call: #{inspect options}")
        secret_key = get_secret_key
        IO.puts("secret_key: #{inspect secret_key}")
        {:ok, jwt_body} = verify_jwt(auth, secret_key, Keyword.get(options, :aud), Keyword.get(options, :iss))
        IO.puts("verify_jwt: #{inspect jwt_body}}")
        {:ok, sub} = Map.fetch(jwt_body, "sub")
#        IO.puts("sub1: #{inspect Map.fetch(jwt_body, "sub")}}")
        answer = validate_user_id(user_id, sub, Mod.get_user_id(user_id))
        IO.puts("validate_user: #{inspect answer}")
        if {:ok, :authorized} == answer do
          IO.puts("1111")
          conn
        else
          IO.puts("222")
          send_resp(conn, 401, conn.body_params["author"]) |> halt()
        end
#        conn |> Plug.Conn.put_flash(answer)
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
