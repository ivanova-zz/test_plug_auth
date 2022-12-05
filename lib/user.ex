defmodule TestPlugAuth.User do
  def validate_user_id(user_id, sub, resource) do
    IO.puts("user_id: #{inspect user_id}")
    IO.puts("sub: #{inspect sub}")
    IO.puts("resource.id: #{inspect resource.id}")
    if user_id == String.to_integer(sub) == resource.id do
      {:ok, :authorized}
    else
      {:error, :unauthorized}
    end
  end
  
end
