defmodule FomanticUI.Components.DropdownComponent do
  use Phoenix.Component

  def selection(assigns) do
    # <input type="hidden" name={@name}>
    ~H"""
    <div phx-update="ignore">
    <script> console.log('first dropdown component') </script>
    <div x-data x-init={"console.log('x-init dropdown'); $($refs.#{@name}).dropdown()"} >
    <div class="ui selection dropdown" x-ref={@name}>
      <%= Phoenix.HTML.Form.text_input @form, :dropdown, type: "hidden", name: @name %>
      <i class="dropdown icon"></i>
      <div class="default text"><%= @name%></div>
      <div class="scrollhint menu">
      <%= for item <- @items do %>
      <div class="item" phx-click="dropdown-select" phx-value-name={@name} phx-value-item={item}>
        <%= item %>
      </div>
      <% end %>
      </div>
    </div>
    </div>
    </div>
    """
  end

  ## Privates
end
