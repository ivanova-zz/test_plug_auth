defmodule TestPlugAuth do
#  import Plug.Conn
  import TokenHelper
  def init(options) do
    IO.puts("options: #{inspect options}")
    options
  end
  def call(conn, options) do
    IO.puts("conn: #{inspect conn}")
    IO.puts("user_id: #{inspect conn.body_params[options[:key]]}")
    IO.puts("req_headers: #{inspect conn.req_headers}")
    auth = get_token(conn.req_headers)
    IO.puts("authorization: #{inspect auth}")
    IO.puts("token: #{inspect conn.req_headers[:plug_session_fetch][:authorization]}")
    IO.puts("options_call: #{inspect options}")
    conn
  end
end
