defmodule TestPlugAuth.User do
  def validate_user_id(user_id, sub, resource) do
    if user_id == String.to_integer(sub) && String.to_integer(sub) == resource.id do
      {:ok, :authorized}
    else
      {:error, :unauthorized}
    end
  end
  
end
