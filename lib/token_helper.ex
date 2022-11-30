defmodule TokenHelper do
  def get_token(headers) do
    Enum.reduce(headers, [], fn({k,v}, acc) ->
      if k == "authorization" do
        acc ++ v
      else
        acc
      end
    end)
    |> String.split(" ")
    |> List.last
  end
end
