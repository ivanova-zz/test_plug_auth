defmodule TestPlugAuthTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest TestPlugAuth

  test "greets the world" do
    assert TestPlugAuth.hello() == :world
  end
end
