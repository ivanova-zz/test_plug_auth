defmodule Config do
  def get_secret_key do
    Envar.get("SECRET_KEY", Application.fetch_env!(:test_plug_auth, :secret_key))
  end
end
