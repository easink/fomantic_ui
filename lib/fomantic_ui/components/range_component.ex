defmodule FomanticUI.Components.RangeComponent do
  @moduledoc false
  use Phoenix.LiveComponent
  use Phoenix.HTML

  # defstruct value: 0,
  #           min: 0,
  #           max: 100,
  #           steps: 1,
  #           enable: true

  def render(assigns) do
    ~L"""
    <form phx-change="input-range" phx-submit="save" phx-target="#range-<%= @name %>">
      <div class="range range-primary" id="range-<%= @name %>">
        <input type="range" name="<%= @name %>" min="<%= @min %>" max="<%= @max %>" value="<%= @value %>" phx-debounce="200" <%= unless @enable, do: "disabled=\"disabled\"" %>>
        <output id="<%= @name %>"><%= @value %></output>
      </div>
    </form>
    """
  end

  def mount(socket) do
    init = [
      # active: false,
      # selected: nil
    ]

    {:ok, assign(socket, init)}
  end

  def update(params, socket) do
    values = [
      name: params[:id],
      value: params[:value] || 0,
      min: params[:min] || 0,
      max: params[:max] || 100,
      steps: params[:steps] || 1,
      enable: true
    ]

    # {:ok, assign(socket, range: range, id: id)}
    {:ok, assign(socket, values)}
  end

  def handle_event("input-range", params, socket) do
    id = socket.assigns.name
    value = Map.get(params, Atom.to_string(id))

    send(self(), {:range, id, value})

    {:noreply, assign(socket, value: value)}
  end

  # def handle_event("select", %{"item" => item}, socket) do
  #   # IO.inspect(binding(), label: "SELECT", limit: :infinity)
  #   send(self(), {:dropdown, socket.assigns.id, item})
  #   {:noreply, assign(socket, active: false)}
  # end

  # def handle_event(a, b, socket) do
  #   # IO.inspect(binding(), label: "UNKNOWN DROPDOWN EVENT", limit: :infinity)
  #   {:noreply, socket}
  # end

  ## Privates
end
