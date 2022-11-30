defmodule TestPlugAuth do
#  import Plug.Conn
  import TokenHelper

  defmacro __using__(options) do
    IO.puts("options in using: #{inspect options}")
    behaviour = get_module(Keyword.get(options, :module))
    IO.puts("behaviour in using: #{inspect behaviour}")
    IO.puts("caller: #{inspect  __CALLER__.module }")
    module = __CALLER__.module
             |> Atom.to_string
             |> String.replace("Web.Router", ".Guardian")
             |> String.to_atom
    IO.puts("caller: #{inspect  module}")
    quote do
      alias unquote(behaviour)
#      def unquote(:check_user)() do
#        unquote(behaviour).get_user_id()
#      end
    end
  end

  def init(options) do
    options
  end
  def call(conn, options) do
    IO.puts("conn: #{inspect conn}")
    IO.puts("user_id: #{inspect conn.body_params[options[:key]]}")
    IO.puts("req_headers: #{inspect conn.req_headers}")
    auth = get_token(conn.req_headers)
    IO.puts("authorization: #{inspect auth}")
    IO.puts("test_check_user: #{inspect check_user()}")
    IO.puts("options_call: #{inspect options}")
    conn
  end

  def check_user do
    "test method in plug"
  end
end
