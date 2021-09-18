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

  admin_state          = true
  hold_interval        = 2000
  detection_interval   = 120
  detection_multiplier = 10
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

  equal "holdIntvl" {
    description = "holdIntvl"
    got         = data.aci_rest.epControlP.content.holdIntvl
    want        = "2000"
  }

  equal "rogueEpDetectIntvl" {
    description = "rogueEpDetectIntvl"
    got         = data.aci_rest.epControlP.content.rogueEpDetectIntvl
    want        = "120"
  }

  equal "rogueEpDetectMult" {
    description = "rogueEpDetectMult"
    got         = data.aci_rest.epControlP.content.rogueEpDetectMult
    want        = "10"
  }
}
