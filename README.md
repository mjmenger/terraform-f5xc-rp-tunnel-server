## Deploy and configure reverse proxy tunnel server on F5 Distributed Cloud


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.14.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.3 |
| <a name="requirement_volterra"></a> [volterra](#requirement\_volterra) | 0.11.34 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.14.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_volterra"></a> [volterra](#provider\_volterra) | 0.11.34 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.frps](https://registry.terraform.io/providers/hashicorp/helm/2.14.0/docs/resources/release) | resource |
| [random_integer.authtoken_length](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_string.authtoken](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [volterra_http_loadbalancer.http](https://registry.terraform.io/providers/volterraedge/volterra/0.11.34/docs/resources/http_loadbalancer) | resource |
| [volterra_origin_pool.control](https://registry.terraform.io/providers/volterraedge/volterra/0.11.34/docs/resources/origin_pool) | resource |
| [volterra_origin_pool.http](https://registry.terraform.io/providers/volterraedge/volterra/0.11.34/docs/resources/origin_pool) | resource |
| [volterra_tcp_loadbalancer.control](https://registry.terraform.io/providers/volterraedge/volterra/0.11.34/docs/resources/tcp_loadbalancer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_f5xc_appstack_site"></a> [f5xc\_appstack\_site](#input\_f5xc\_appstack\_site) | the name F5 Distributed Cloud App Stack site | `string` | n/a | yes |
| <a name="input_f5xc_dns_zone"></a> [f5xc\_dns\_zone](#input\_f5xc\_dns\_zone) | the previously configured dns zone to use when creating frp server load balancers. | `string` | n/a | yes |
| <a name="input_f5xc_namespace"></a> [f5xc\_namespace](#input\_f5xc\_namespace) | the F5 Distributed Cloud namespace in which the frp server origin pools and load balancers are deployed. | `string` | n/a | yes |
| <a name="input_f5xc_tenant_id"></a> [f5xc\_tenant\_id](#input\_f5xc\_tenant\_id) | the id of the F5 Distributed Cloud tenant. this is not the name of the tenant, but the id found user Account -> Tenant Overview. | `string` | n/a | yes |
| <a name="input_rp_tunnel_app_name"></a> [rp\_tunnel\_app\_name](#input\_rp\_tunnel\_app\_name) | the name of the application proxied by the frp client. | `string` | n/a | yes |
| <a name="input_rp_tunnel_auth_token"></a> [rp\_tunnel\_auth\_token](#input\_rp\_tunnel\_auth\_token) | value of the token used by the frp server to authenticate frp clients. | `string` | `""` | no |
| <a name="input_rp_tunnel_chart_name"></a> [rp\_tunnel\_chart\_name](#input\_rp\_tunnel\_chart\_name) | the name of the helm chart to use for the frp server deployment | `string` | `"f5xc-rp-tunnel"` | no |
| <a name="input_rp_tunnel_chart_repository"></a> [rp\_tunnel\_chart\_repository](#input\_rp\_tunnel\_chart\_repository) | the url of the helm chart repository where the f5xc-frps chart is stored. | `string` | `"https://f5businessdevelopment.github.io/helm-charts"` | no |
| <a name="input_rp_tunnel_chart_version"></a> [rp\_tunnel\_chart\_version](#input\_rp\_tunnel\_chart\_version) | the version of the helm chart to use | `string` | `"0.0.8"` | no |
| <a name="input_rp_tunnel_control_listener_port"></a> [rp\_tunnel\_control\_listener\_port](#input\_rp\_tunnel\_control\_listener\_port) | the port used by the frp server to listen for frp client requests. | `number` | n/a | yes |
| <a name="input_rp_tunnel_create_namespace"></a> [rp\_tunnel\_create\_namespace](#input\_rp\_tunnel\_create\_namespace) | if true, a kubernetes namespace will be created with the name set to rp\_tunnel\_namespace. | `bool` | `true` | no |
| <a name="input_rp_tunnel_http_listener_port"></a> [rp\_tunnel\_http\_listener\_port](#input\_rp\_tunnel\_http\_listener\_port) | the port used by the frp server to listen for http application end user requests. | `number` | n/a | yes |
| <a name="input_rp_tunnel_https_listener_port"></a> [rp\_tunnel\_https\_listener\_port](#input\_rp\_tunnel\_https\_listener\_port) | the port used by the frp server to listen for https application end user requests | `number` | n/a | yes |
| <a name="input_rp_tunnel_instance_name"></a> [rp\_tunnel\_instance\_name](#input\_rp\_tunnel\_instance\_name) | the value used as prefix for all frp server deployment artifacts (e.g. myfrps). | `string` | n/a | yes |
| <a name="input_rp_tunnel_namespace"></a> [rp\_tunnel\_namespace](#input\_rp\_tunnel\_namespace) | the kubernetes namespace in which to deploy the frp server. (e.g. frps). While default is possible it is not recommended. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release_notes"></a> [helm\_release\_notes](#output\_helm\_release\_notes) | n/a |
| <a name="output_rp_tunnel_auth_token"></a> [rp\_tunnel\_auth\_token](#output\_rp\_tunnel\_auth\_token) | n/a |
<!-- END_TF_DOCS -->