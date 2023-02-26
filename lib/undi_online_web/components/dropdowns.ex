defmodule UndiOnlineWeb.Components.Dropdowns do
  @moduledoc """
  Dropdown components
  """
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @doc """
  Renders a dropdown.

  ## Examples

      <.dropdown>
        <:action>
          <.button phx-click={toggle_dropdown("#dropdown-menu")}>Save</.button>
        </:action>
        <:menu>
          <.link>Home</.link>
          <.link>Logout</.link>
        </:menu>
      </.dropdown>

      <.dropdown>
        <:toggle class="px-2 btn btn-secondary">
          <Icon.options_vertical />
        </:toggle>
        <:menu>
          <.link>Home</.link>
          <.link>Logout</.link>
        </:menu>
      </.dropdown>

  """
  attr :id, :string, default: "dropdown"
  attr :align, :string, default: "left"
  attr :rest, :global, default: %{"class" => "relative inline-block"}
  slot :action, default: []
  slot :toggle do
    attr :class, :any
  end
  slot :menu do
    attr :align, :string
  end
  def dropdown(assigns) do
    assigns =
      assigns
      |> assign_new(:dropdown_id, fn -> "#{Map.get(assigns, :id)}-menu" end)

    ~H"""
    <div id={@id} {@rest}>
      <%= for action <- @action do %>
        <%= render_slot(action) %>
      <% end %>
      <%= for toggle <- @toggle do %>
        <.dropdown_toggle on_click={toggle_dropdown("##{@dropdown_id}")} class={Map.get(toggle, :class)}>
          <%= render_slot(toggle) %>
        </.dropdown_toggle>
      <% end %>
      <%= for menu <- @menu do %>
        <.dropdown_menu id={@dropdown_id} align={Map.get(menu, :align, @align)} class={Map.get(menu, :class)}>
          <%= render_slot(menu) %>
        </.dropdown_menu>
      <% end %>
    </div>
    """
  end

  attr :type, :string, default: "button"
  attr :on_click, JS, default: %JS{}
  attr :class, :any
  attr :rest, :global, default: %{"class" => "flex items-center gap-2"}
  slot :inner_block
  def dropdown_toggle(%{type: type} = assigns) when type in ["a", "link"] do
    ~H"""
    <a href="#" phx-click={@on_click} {@rest}>
      <%= render_slot(@inner_block) %>
    </a>
    """
  end

  def dropdown_toggle(assigns) do
    ~H"""
    <button type="button" phx-click={@on_click} {@rest}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  attr :id, :string, default: "dropdown-menu"
  attr :align, :string, default: "left"
  attr :class, :any
  attr :fallback_class, :string, default: "border shadow-xl menu bg-base-100 border-base-200 rounded-box w-52"
  slot :inner_block
  def dropdown_menu(%{align: "right"} = assigns) do
    ~H"""
    <.focus_wrap id={@id} phx-click-away={hide("##{@id}")} phx-window-keydown={hide("##{@id}")} phx-key="escape" class="absolute right-0 z-10 hidden origin-top-right">
      <div phx-click-away={hide(@id)} class={@class || @fallback_class}>
        <%= render_slot(@inner_block) %>
      </div>
    </.focus_wrap>
    """
  end

  def dropdown_menu(%{align: "center"} = assigns) do
    ~H"""
    <.focus_wrap id={@id} phx-click-away={hide("##{@id}")} phx-window-keydown={hide("##{@id}")} phx-key="escape" class="absolute z-10 hidden left-1/2 -translate-x-1/2 origin-top-right">
      <div phx-click-away={hide(@id)} class={@class || @fallback_class}>
        <%= render_slot(@inner_block) %>
      </div>
    </.focus_wrap>
    """
  end

  def dropdown_menu(assigns) do
    ~H"""
    <.focus_wrap id={@id} phx-click-away={hide(@id)} phx-window-keydown={hide("##{@id}")} phx-key="escape" class="absolute left-0 z-10 hidden origin-top-left">
      <div phx-click-away={hide(@id)} class={@class || @fallback_class}>
        <%= render_slot(@inner_block) %>
      </div>
    </.focus_wrap>
    """
  end

  def toggle_dropdown(id, js \\ %JS{}) do
    js
    |> JS.toggle(
      to: id,
      in: {"transition ease-out duration-200", "opacity-0 translate-y-1", "opacity-100 translate-y-0"},
      out: {"transition ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 translate-y-1"}
    )
  end

  defp hide(id, js \\ %JS{}) do
    js
    |> JS.hide(to: id, transition: {"transition ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 translate-y-1"})
  end
end
