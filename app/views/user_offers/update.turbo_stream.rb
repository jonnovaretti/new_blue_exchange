
<%= turbo_stream.replace "#{dom_id(offer)}_line" do %>
    <%= render "offer_line", offer: offer %>
<% end %>
