defmodule UndiOnlineWeb.Components.Cards do
  @moduledoc """
  Collection of card related components
  """
  use Phoenix.Component

  @doc """
  Renders a basic card.

  ## Examples

      <.card>
        Card content
      </.card>

  """
  attr :shadow, :boolean, default: false
  attr :border, :boolean, default: false
  attr :rest, :global

  slot :title
  slot :body
  slot :inner_block, required: true
  def card(assigns) do
    ~H"""
    <div
      class={[
        "card bg-base-100",
        @shadow && "shadow-lg",
        @border && "border border-base-300"
      ]}
      {@rest}
    >
      <div :for={title <- @title} class="px-4 py-2 border-b border-base-200">
        <%= render_slot(title) %>
      </div>
      <%= if @body != [] do %>
        <div :for={body <- @body} class="card-body">
          <%= render_slot(body) %>
        </div>
      <% else %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </div>
    """
  end
end
