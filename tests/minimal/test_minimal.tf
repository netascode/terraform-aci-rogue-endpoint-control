terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  admin_state = true
}

data "aci_rest" "epControlP" {
  dn = "uni/infra/epCtrlP-default"

  depends_on = [module.main]
}

resource "test_assertions" "epControlP" {
  component = "epControlP"

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest.epControlP.content.adminSt
    want        = "enabled"
  }
}
