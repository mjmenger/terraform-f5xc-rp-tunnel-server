terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.34"
    }
    http = {
      source = "hashicorp/http"
      version = "3.4.3"
    }   
    helm = {
      source = "hashicorp/helm"
      version = "2.14.0"
    }     
  }
}

provider "volterra" {
  # Configuration options
  # define the VOLT_API_URL environment variable before using this provider
}

provider "helm" {
  kubernetes {
    # define the KUBE_CONFIG_PATH environment variable before using this provider
  }
}
