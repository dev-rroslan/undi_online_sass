defmodule UndiOnline.Mailer do
  @moduledoc false
  use Swoosh.Mailer, otp_app: :undi_online

  import Swoosh.Email, only: [new: 0, from: 2, html_body: 2, text_body: 2]

  # Base email function should contain all common features
  def base_email do
    new()
    |> from(from_email())
  end

  # Inline CSS so it works in all browsers
  def premail(email) do
    html = Premailex.to_inline_css(email.html_body)
    text = Premailex.to_text(email.html_body)

    email
    |> html_body(html)
    |> text_body(text)
  end

  defp from_email, do: Application.get_env(:undi_online, :from_email)
end
