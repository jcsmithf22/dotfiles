return {
  on_attach = function(client, buf_id) client.server_capabilities.hoverProvider = false end,
}
