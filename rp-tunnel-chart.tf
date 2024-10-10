
locals {

}

resource "helm_release" "frps" {
  name             = var.rp_tunnel_instance_name
  namespace        = var.rp_tunnel_namespace
  repository       = var.rp_tunnel_chart_repository
  chart            = var.rp_tunnel_chart_name
  version          = var.rp_tunnel_chart_version
  create_namespace = var.rp_tunnel_create_namespace

  set {
    name  = "RP_SERVER_SSH_PORT"
    value = var.rp_tunnel_control_listener_port 
  }
  set {
    name  = "RP_SERVER_HTTP_PORT"
    value = var.rp_tunnel_http_listener_port 
  }
  # set {
  #   name  = "vhostHTTPSPort"
  #   value = var.rp_tunnel_https_listener_port 
  # }
  # set {
  #   name  = "authToken"
  #   value = local.rp_tunnel_auth_token
  # }
  # set {
  #   name  = "frpsPublicAddress"
  #   value = format("%s.%s", var.rp_tunnel_instance_name, var.f5xc_dns_zone )
  # }
  set {
    name  = "RP_SERVER_NAME"
    value = format("%s.%s", var.rp_tunnel_instance_name, var.f5xc_dns_zone )
  }
  # set {
  #   name  = "frpcProxyType"
  #   value = var.frpc_proxy_type
  # }
  # set {
  #   name  = "frpcProxyAddress"
  #   value = var.frpc_proxy_address
  # }
  # set {
  #   name  = "frpcProxyPort"
  #   value = var.frpc_proxy_port
  # }
  # set {
  #   name = "caCert"
  #   value = file("${path.module}/certs/ca.crt")
  # }
  # set {
  #   name = "serverCert"
  #   value = file("${path.module}/certs/server.crt")
  # }
  # set {
  #   name = "serverKey"
  #   value = file("${path.module}/certs/server.key")
  # }

}

