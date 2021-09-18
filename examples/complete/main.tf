module "aci_rogue_endpoint_control" {
  source  = "netascode/rogue-endpoint-control/aci"
  version = ">= 0.0.1"

  admin_state          = true
  hold_interval        = 2000
  detection_interval   = 120
  detection_multiplier = 10
}
