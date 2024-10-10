output helm_release_notes {
    value = helm_release.frps.metadata[0].notes
}
output rp_tunnel_auth_token {
    value = local.rp_tunnel_auth_token
}