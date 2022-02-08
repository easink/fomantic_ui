defmodule FomanticUI.Components.ModalComponent do
  use Phoenix.Component
  # use Phoenix.HTML

  def modal(assigns) do
    ~H"""
    <div x-data>
      <button class="button" @click={"$($refs.#{@name}).modal('show');"}>
        Modal
      </button>
      <div class="ui modal" x-ref={@name}>
        <div>
          <%= render_block(@inner_block) %>
        </div>

        <div class="actions">
          <div class="ui black deny button">
            Nope
          </div>
          <div class="ui positive right labeled icon button">
            Yep, that's me
            <i class="checkmark icon"></i>
          </div>
        </div>

      </div>
    </div>
    """
  end
end
