defmodule TokenHelper do
  use Joken.Config

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
    |> Enum.reduce("Elixir", fn(x, acc) -> acc <> "." <> Atom.to_string(x) end)
    |> String.to_atom
  end

  def create_signer(secret) do
    Joken.Signer.create("HS512", secret)
  end

  def token_config(aud, iss) do
    IO.puts("aud: #{inspect to_string(aud)}")
    IO.puts("iss: #{inspect to_string(iss)}")
    default_claims(default_exp: 31_537_000, aud: to_string(aud), iss: to_string(iss))
  end

  def verify_jwt(token, secret, aud, iss) do
    signer = create_signer(secret)

    token_config(aud, iss)
    |> Joken.verify_and_validate(token, signer)
  end
end
