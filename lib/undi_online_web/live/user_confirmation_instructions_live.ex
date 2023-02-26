defmodule UndiOnlineWeb.UserConfirmationInstructionsLive do
  use UndiOnlineWeb, :live_view

  alias UndiOnline.Users

  def render(assigns) do
    ~H"""
    <.header class="text-center">Resend confirmation instructions</.header>

    <.simple_form :let={f} for={%{}} as={:user} id="resend_confirmation_form" phx-submit="send_instructions">
      <.input field={{f, :email}} type="email" label="Email" required />
      <:actions>
        <.button class="w-full" phx-disable-with="Sending...">Resend confirmation instructions</.button>
      </:actions>
    </.simple_form>

    <p class="text-center">
      <.link href={~p"/users/register"}>Register</.link>
      |
      <.link href={~p"/users/log_in"}>Log in</.link>
    </p>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("send_instructions", %{"user" => %{"email" => email}}, socket) do
    if user = Users.get_user_by_email(email) do
      Users.deliver_user_confirmation_instructions(
        user,
        &url(~p"/users/confirm/#{&1}")
      )
    end

    info =
      "If your email is in our system and it has not been confirmed yet, you will receive an email with instructions shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
