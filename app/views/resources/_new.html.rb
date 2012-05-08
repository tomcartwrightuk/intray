<% form_for :resource, @user, :url => user_path, :html => { :multipart => true } do |form| %>
  <%= form.file_field :resource %>
<% end %>
