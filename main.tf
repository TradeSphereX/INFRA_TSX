############################################# provider vsphere #########################################################
# variable vsphere_user
# variable vsphere_password
# variable vsphere_server
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

#################################################### data ##############################################################

data "vsphere_datacenter" "pclab" {
  name = "Infra_Pierre"
}

data "vsphere_datastore" "datastore1" {
  name          = "datastore2"
  datacenter_id = data.vsphere_datacenter.pclab.id
}

data "vsphere_resource_pool" "resources" {
  name          = "Resources"
  datacenter_id = data.vsphere_datacenter.pclab.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.pclab.id
}

#################################################### resource ##########################################################

resource "vsphere_virtual_machine" "vm1" {
  name             = "VM1"
  resource_pool_id = data.vsphere_resource_pool.resources.id
  datastore_id     = data.vsphere_datastore.datastore1.id
  num_cpus         = 2
  memory           = 4096
  guest_id         = "other3xLinux64Guest"
  wait_for_guest_ip_timeout = -1
  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout = -1
  network_interface {
    network_id   = data.vsphere_network.network.id
   ### adapter_type = "vmxnet3"
  }
  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    thin_provisioned = true
  }
  scsi_type = "lsilogic-sas"
}

resource "vsphere_virtual_machine" "vm2" {
  name             = "VM2"
  resource_pool_id = data.vsphere_resource_pool.resources.id
  datastore_id     = data.vsphere_datastore.datastore1.id
  num_cpus         = 2
  memory           = 4096
  guest_id         = "other3xLinux64Guest"
  wait_for_guest_ip_timeout = -1
  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout = -1
  network_interface {
    network_id   = data.vsphere_network.network.id
   ## adapter_type = "vmxnet3"
  }
  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    thin_provisioned = true
  }
  scsi_type = "lsilogic-sas"
}

resource "vsphere_virtual_machine" "vm3" {
  name             = "VM3"
  resource_pool_id = data.vsphere_resource_pool.resources.id
  datastore_id     = data.vsphere_datastore.datastore1.id
  num_cpus         = 2
  memory           = 4096
  guest_id         = "other3xLinux64Guest"
  wait_for_guest_ip_timeout = -1
  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout = -1
  network_interface {
    network_id   = data.vsphere_network.network.id
    ## adapter_type = "vmxnet3"
  }
  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    thin_provisioned = true
  }
  scsi_type = "lsilogic-sas"
}


### For each to refactor