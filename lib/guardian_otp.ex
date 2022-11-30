defmodule GuardianOtp do

  def __using__(options) do
    quote bind_quoted: [options: options] do
      use Guardian, otp_app: unquote(Keyword.get(options, :otp_app))

      def subject_for_token(user, _claims) do
        sub = to_string(user.id)
        {:ok, sub}
      end

      def subject_for_token(_, _) do
        {:error, :reason_for_error}
      end

      def resource_from_claims(claims) do
        id = claims["sub"]
        resource = unquote(Keyword.get(options, :account)).get_user!(id)
        {:ok,  resource}
      end

      def resource_from_claims(_claims) do
        {:error, :reason_for_error}
      end
    end
  end
  
end
