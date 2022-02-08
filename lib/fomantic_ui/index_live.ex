defmodule FomanticUI.IndexLive do
  use Phoenix.LiveView
  alias FomanticUI.Components.DropdownComponent
  alias FomanticUI.Components.ModalComponent
  alias FomanticUI.Components.ProgressComponent
  alias FomanticUI.Components.UploadComponent

  alias FomanticUI.Router.Helpers, as: Routes

  @impl Phoenix.LiveView
  def render(assigns) do
    # <ProgressComponent.progress_test id="myprogress_test" percent={@progress_percent}/>
    ~H"""
    <.form let={f} for={@changeset} phx-change="index-validate" phx-submit="index-save">

    <h1>Dropdown:</h1>
      <DropdownComponent.selection form={f} name={@dropdown_name} items={@dropdown_items} />
      SELECTED: <%= if @dropdown_selected, do: @dropdown_selected %>
    <br>
    <%= Phoenix.HTML.Form.submit "Save" %>
    </.form>

    <h1>Modal:</h1>
      <ModalComponent.modal name={@modal_name}>
        Yada yada
      </ModalComponent.modal>
    <br>
    <h1>Progress:</h1>
      <ProgressComponent.progress id="myprogress" percent={@progress_percent}/>
    <br>
    <h1>Uploads:</h1>
      <form id="upload-form" phx-submit="save" phx-change="validate">
        <button class="ui button" phx-drop-target={@uploads.avatar.ref} >Drop files here...</button>
        <%# live_file_input @uploads.avatar, webkitdirectory: true %>
        <%= live_file_input @uploads.avatar %>
        <button type="submit">Upload</button>
      </form>
      <UploadComponent.uploads uploads={@uploads}/>
    <br>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    dropdown_items = [
      "Cat",
      "Dog",
      "Bird",
      "Rabbit",
      "Squirrel",
      "Horse",
      "Turtle",
      "Parrot"
    ]

    dropdown_name = "Pet"

    :timer.send_interval(1000, :tick)

    {:ok,
     socket
     |> assign(:dropdown_name, dropdown_name)
     |> assign(:dropdown_items, dropdown_items)
     |> assign(:dropdown_selected, nil)
     |> assign(:modal_name, "my_modal")
     |> assign(:progress_percent, 0)
     |> assign(:uploaded_files, [])
     |> assign(:changeset, nil)
     |> allow_upload(:avatar, accept: :any, max_entries: 2)}
  end

  # def handle_event("input-range", %{"unique_range" => value}, socket) do
  #   IO.inspect(binding(), label: "UNKOWN LIVE EVENT")
  #   {:noreply, assign(socket, range_value: value)}
  # end

  @impl Phoenix.LiveView
  def handle_event("index-validate", _params, socket) do
    IO.inspect(socket, label: "index-validate", structs: false)
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("index-save", _params, socket) do
    IO.inspect(socket, label: "index-save", structs: false)
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :avatar, ref)}
  end

  @impl Phoenix.LiveView
  def handle_event("save", _params, socket) do
    uploaded_entries(socket, :avatar)
    |> IO.inspect(label: "UPLOADED")

    uploaded_files =
      consume_uploaded_entries(socket, :avatar, fn %{path: path} = pathentry, entry ->
        IO.inspect(binding(), label: "QQQ", structs: false)
        dest = Path.join([:code.priv_dir(:fomantic_ui), "static", "uploads", Path.basename(path)])
        # File.cp!(path, dest)
        Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  # @impl Phoenix.LiveComponent
  def handle_event("dropdown-select", %{"item" => item, "name" => _name}, socket) do
    IO.inspect(binding(), label: "DROPDOWN SELECT", limit: :infinity)
    {:noreply, assign(socket, dropdown_selected: item)}
  end

  def handle_event(_event, _params, socket) do
    IO.inspect(binding(), label: "UNKNOWN LIVE EVENT")
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_info(:tick, socket) do
    epoch = :erlang.universaltime() |> :erlang.universaltime_to_posixtime()

    socket
    |> assign(progress_percent: rem(epoch, 100))
    |> noreply()
  end

  def handle_info(msg, socket) do
    IO.inspect(binding(), label: "LIVE UNKOWN")
    {:noreply, socket}
  end

  defp noreply(socket), do: {:noreply, socket}
end
