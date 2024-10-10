resource "volterra_origin_pool" "control" {
  name                   = format("%s-%s-control", var.rp_tunnel_instance_name, var.rp_tunnel_chart_name )
  namespace              = var.f5xc_namespace 
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  same_as_endpoint_port  = true
  no_tls                 = true
  port                   = var.rp_tunnel_control_listener_port
  origin_servers {
    k8s_service {
      site_locator {
        site {
            tenant    = var.f5xc_tenant_id
            namespace = "system"
            name      = var.f5xc_appstack_site
        }
      }
      service_name   = format("%s-%s.%s", var.rp_tunnel_instance_name, var.rp_tunnel_chart_name, var.rp_tunnel_namespace)
      inside_network = true
    }
  }
}

resource "volterra_origin_pool" "http" {
  name                   = format("%s-%s-http", var.rp_tunnel_instance_name, var.rp_tunnel_chart_name )
  namespace              = var.f5xc_namespace 
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  same_as_endpoint_port  = true
  no_tls                 = true
  port                   = var.rp_tunnel_http_listener_port
  origin_servers {
    k8s_service {
      site_locator {
        site {
            tenant    = var.f5xc_tenant_id
            namespace = "system"
            name      = var.f5xc_appstack_site
        }
      }
      service_name   = format("%s-%s.%s", var.rp_tunnel_instance_name, var.rp_tunnel_chart_name, var.rp_tunnel_namespace)
      inside_network = true
    }
  }
}

resource "volterra_tcp_loadbalancer" "control" {
  name      = format("%s-%s-control", var.rp_tunnel_instance_name, var.rp_tunnel_chart_name )
  namespace = var.f5xc_namespace 
  domains   = [format("%s.%s", var.rp_tunnel_instance_name, var.f5xc_dns_zone )]

  origin_pools_weights {
    pool {
      tenant    = var.f5xc_tenant_id
      namespace = var.f5xc_namespace 
      name      = volterra_origin_pool.control.name
    }
    priority = 1
    weight = 1
  }
  advertise_on_public_default_vip = true
  tcp                             = true
  listen_port                     = var.rp_tunnel_control_listener_port
  dns_volterra_managed            = true
}

resource volterra_http_loadbalancer "http" {
  name      = format("%s-%s-http", var.rp_tunnel_instance_name, var.rp_tunnel_chart_name )
  namespace = var.f5xc_namespace 
  domains   = [format("%s.%s", var.rp_tunnel_app_name, var.f5xc_dns_zone)]
  https_auto_cert {
    http_redirect = true
    add_hsts = false
    port = 443
    tls_config {
      default_security = true
    }
    no_mtls = true
    pass_through = true
    enable_path_normalize = true
    non_default_loadbalancer = true
    connection_idle_timeout = 120000
    http_protocol_options {
      http_protocol_enable_v1_v2 = true
    }
  }
  advertise_on_public_default_vip = true
  default_route_pools {
    pool {
      tenant    = var.f5xc_tenant_id
      namespace = var.f5xc_namespace 
      name      = volterra_origin_pool.http.name
    }
    weight   = 1
    priority = 1
  }
  enable_api_discovery {
    disable_learn_from_redirect_traffic = true
    discovered_api_settings {
      purge_duration_for_inactive_discovered_apis = 2
    }
  }
  disable_bot_defense         = true
  disable_api_definition      = true
  disable_ip_reputation       = true
  disable_client_side_defense = true
  disable_threat_mesh         = true
  l7_ddos_action_default      = true
}

