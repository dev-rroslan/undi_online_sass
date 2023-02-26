defmodule UndiOnlineWeb.MemberLive.InvitationFormComponent do
  @moduledoc """
  This component is used for creating a account membership
  invitation.
  """
  use UndiOnlineWeb, :live_component

  alias UndiOnline.Accounts
  alias UndiOnline.Accounts.Invitation

  @impl true
  def update(assigns, socket) do
    changeset = Accounts.change_invitation(%Invitation{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"invitation" => invitation_params}, socket) do
    case Accounts.create_invitation(
           socket.assigns.account,
           socket.assigns.current_user,
           invitation_params
         ) do
      {:ok, _invitation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Member invited successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
