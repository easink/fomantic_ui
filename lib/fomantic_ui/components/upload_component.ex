defmodule FomanticUI.Components.ProgressComponent do
  use Phoenix.Component

  def progress(assigns) do
    ~H"""
    <div x-data={"
      {
        percent: #{@percent},
        get_percent() { return this.percent },
      }
      "}
      x-init={"$($refs.#{@id}).progress({percent: get_percent()})"}
      phx-update="ignore"
    >
      <div class="ui progress" id="qqq" x-ref={@id}>
        <div class="bar">
          <div class="progress"></div>
        </div>
      </div>
    </div>
    """
  end

  def progress_test(assigns) do
    ~H"""
    <div x-data={"{ percent: 0 }"}>
    <div
      x-init={"
        percent = #{@percent}
        $watch('percent', value => console.log(value))
      "}
    >
      <div class="ui progress" id="qqq" x-ref={@id}>
        <div class="bar">
          <div class="progress"></div>
        </div>
      </div>
    </div>
    </div>
    """
  end
end
