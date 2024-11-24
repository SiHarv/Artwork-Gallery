json.array! @arts, partial: "arts/art", as: :art
<!-- Example link to delete an art piece asynchronously -->
<%= link_to 'Delete', art_path(art), method: :delete, remote: true, data: { confirm: 'Are you sure?' } %>

