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

data "vsphere_datacenter" "datacenter" {
  name = "ts-dc-01"
}

data "vsphere_datastore" "datastore" {
  name          = "ts-datastore-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


################################################## cluster #############################################################

data "vsphere_compute_cluster" "cluster" {
  name          = "ts-cluster-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

################################################### network ############################################################

data "vsphere_network" "network" {
  name          = "ts-VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

##################################################### vm ###############################################################

resource "vsphere_virtual_machine" "vm" {
  name             = "ts-vm-01"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  memory           = 4096
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
}