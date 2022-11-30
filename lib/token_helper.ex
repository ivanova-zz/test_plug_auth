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

  def get_module(mod) do
    mod
    |> Tuple.to_list
    |> List.last
    |> Enum.reduce("", fn(x, acc) -> acc <> "." <> Atom.to_string(x) end)
    |> String.replace(".", "", global: false)
  end
end
