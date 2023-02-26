defmodule UndiOnlineWeb.LayoutComponents do
  @moduledoc """
  Provides UI components used in the layouts.
  """
  use UndiOnlineWeb, :verified_routes
  use Phoenix.Component

  import UndiOnlineWeb.Components.Dropdowns, only: [dropdown: 1]

  attr :mobile, :boolean, default: false
  attr :current_user, :any
  def user_menu(%{mobile: true} = assigns) do
    ~H"""
    <.link
      :if={!@current_user}
      href={~p"/users/log_in"}
      class={[
        "btn btn-link text-base-content"
      ]}>Log in</.link>

    <.link
      :if={!@current_user}
      href={~p"/users/register"}
      class={[
        "btn btn-primary"
      ]}>Register</.link>

    <.link :if={@current_user} href={~p"/users/settings"} class="w-full btn btn-link text-base-content">Settings</.link>
    <.link :if={@current_user} href={~p"/accounts"} class="w-full btn btn-link text-base-content">Accounts</.link>
    <.link :if={@current_user} href={~p"/users/log_out"} method="delete" class="w-full btn btn-link text-base-content">Log out</.link>
    """
  end

  def user_menu(assigns) do
    ~H"""
    <.link
      :if={!@current_user}
      href={~p"/users/log_in"}
      class={[
        "btn btn-link text-base-content"
      ]}>Log in</.link>

    <.link
      :if={!@current_user}
      href={~p"/users/register"}
      class={[
        "btn btn-primary"
      ]}>Register</.link>

    <.dropdown :if={@current_user} id={"user-menu#{if @mobile, do: "-mobile"}"}>
      <:toggle class="px-2 btn btn-secondary">
        <Heroicons.user_circle solid class="w-8 h-8" />
      </:toggle>
      <:menu align="right">
        <li><.link href={~p"/users/settings"}>Settings</.link></li>
        <li><.link href={~p"/accounts"}>Accounts</.link></li>
        <li><.link href={~p"/users/log_out"} method="delete">Log out</.link></li>
      </:menu>
    </.dropdown>
    """
  end
end
