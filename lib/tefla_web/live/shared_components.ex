defmodule TeflaWeb.SharedComponents do
  use Phoenix.Component

  def section(assigns) do
    ~H"""
    <section class="section">
      <div class="container">
        <%= render_slot(@inner_block) %>
      </div>
    </section>
    """
  end
end
