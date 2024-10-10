locals {
    rp_tunnel_auth_token = var.rp_tunnel_auth_token == "" ? random_string.authtoken[0].result : var.rp_tunnel_auth_token
}
resource random_integer authtoken_length {
    count = var.rp_tunnel_auth_token == "" ? 1 : 0
    min = 16
    max = 32
}
resource "random_string" "authtoken" {
    count            = var.rp_tunnel_auth_token == "" ? 1 : 0
    length           = random_integer.authtoken_length[0].result
    special          = true
    min_lower        = 1
    min_upper        = 1
    min_numeric      = 1
    override_special = "+-.#$"
}
variable rp_tunnel_instance_name {
    type        = string
    description = "the value used as prefix for all rp server deployment artifacts (e.g. myfrps)."
}
variable rp_tunnel_namespace {
    type        = string
    description = "the kubernetes namespace in which to deploy the rp server. While default is possible it is not recommended."
}
variable rp_tunnel_create_namespace {
    type        = bool
    default     = true
    description = "if true, a kubernetes namespace will be created with the name set to rp_tunnel_namespace."
}
variable rp_tunnel_control_listener_port {
    type        = number
    description = "the port used by the rp server to listen for rp client requests."
}
variable rp_tunnel_http_listener_port {
    type        = number
    description = "the port used by the rp server to listen for http application end user requests."
}
variable rp_tunnel_https_listener_port {
    type        = number
    description = "the port used by the rp server to listen for https application end user requests"
}
variable rp_tunnel_auth_token {
    type        = string
    default     = ""
    description = "value of the token used by the rp server to authenticate rp clients."
}
variable rp_tunnel_app_name {
    type        = string
    description = "the name of the application proxied by the rp client."
}
variable f5xc_appstack_site {
    type        = string
    description = "the name F5 Distributed Cloud App Stack site"
}
variable f5xc_namespace {
    type        = string
    description = "the F5 Distributed Cloud namespace in which the rp server origin pools and load balancers are deployed."
}
variable f5xc_tenant_id {
    type        = string
    description = "the id of the F5 Distributed Cloud tenant. this is not the name of the tenant, but the id found in the F5 Distributed Cloud GUI at User Account -> Tenant Overview."
}
variable f5xc_dns_zone {
    type        = string
    description = "the previously configured dns zone to use when creating rp server load balancers."
}
variable rp_tunnel_chart_repository {
    type        = string
    default     = "https://f5businessdevelopment.github.io/helm-charts"
    description = "the url of the helm chart repository where the f5xc-rp-tunnel chart is stored."
}
variable rp_tunnel_chart_name {
    type        = string
    default     = "f5xc-rp-tunnel"
    description = "the name of the helm chart to use for the frp server deployment"
}
variable rp_tunnel_chart_version {
    type        = string
    default     = "0.0.8"
    description = "the version of the helm chart to use"
}
# variable frpc_proxy_name {
#     type        = string
#     default     = ""
#     description = "the name used by the frp client to identify an application proxy configuration."
# }
# variable frpc_proxy_type {
#     type        = string
#     default     = "http"
#     description = "the type of proxy used by an application proxy configuration. acceptable values are http, https, ... "
# }
# variable frpc_proxy_address {
#     type        = string
#     default     = "web"
#     description = "the address used by the frp client to access the proxied application."
# }
# variable frpc_proxy_port {
#     type        = number
#     default     = 5000
#     description = "the port used by the frp client to access the proxied application."
# }