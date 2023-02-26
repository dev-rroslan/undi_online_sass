defmodule UndiOnline.Accounts.InvitationNotifier do
  @moduledoc """
  This module contains notifications aimed towards the user.
  """
  use Phoenix.Swoosh, view: UndiOnlineWeb.Emails, layout: {UndiOnlineWeb.Emails, :layout}

  import Swoosh.Email
  import UndiOnline.Mailer, only: [base_email: 0, premail: 1]

  @doc """
  This email is used from the Teams module to invite a new user to an account
  """
  def invite_user_email(%{email: email, url: url}) do
    base_email()
    |> subject("Invited to join")
    |> to(email)
    |> render_body("invite_user.html", title: "Invited to join", url: url)
    |> premail()
  end
end
