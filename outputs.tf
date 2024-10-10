output helm_release_notes {
    value = helm_release.frps.metadata[0].notes
}
output frps_auth_token {
    value = local.frps_auth_token
}