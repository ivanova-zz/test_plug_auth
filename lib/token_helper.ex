defmodule TokenHelper do
  def get_token(headers) do
    Enum.reduce(headers, [], fn(x, acc) ->
      el = Tuple.to_list(x)
      if List.first(el) == "authorization" do
        acc ++ List.last(el)
      else
        acc
      end
    end)
  end
end
