defmodule FomanticUI.Components.UploadComponent do
  use Phoenix.Component

  def uploads(assigns) do
    ~H"""
    <%# use phx-drop-target with the upload ref to enable file drag and drop %>
    <section phx-drop-target={@uploads.avatar.ref}>

    <%# render each avatar entry %>
    <%= for entry <- @uploads.avatar.entries do %>
    <article class="upload-entry">

    <figure>
      <%# Phoenix.LiveView.Helpers.live_img_preview/2 renders a client-side preview %>
      <%# live_img_preview entry %>
      <figcaption><%= entry.client_name %></figcaption>
    </figure>

    <%# entry.progress will update automatically for in-flight entries %>
    <progress value={entry.progress} max="100"> <%= entry.progress %>% </progress>

    <%# a regular click event whose handler will invoke Phoenix.LiveView.cancel_upload/3 %>
    <button phx-click="cancel-upload" phx-value-ref={entry.ref} aria-label="cancel">&times;</button>

    <%# Phoenix.LiveView.Helpers.upload_errors/2 returns a list of error atoms %>
    <%= for err <- upload_errors(@uploads.avatar, entry) do %>
      <p class="alert alert-danger"><%= error_to_string(err) %></p>
    <% end %>

    </article>
    <% end %>

    </section>
    """
  end

  def error_to_string(:too_large), do: "Too large"
  def error_to_string(:too_many_files), do: "You have selected too many files"
  def error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
