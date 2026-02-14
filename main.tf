resource "hcloud_primary_ip" "primary_ip_1" {
  name          = "primary_ip_test"
  location      = "hel1"
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_firewall" "firewall" {
  name = "zammad-firewall"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

}

resource "hcloud_server" "server_test" {
  name         = "zammad-server"
  image        = "ubuntu-24.04"
  server_type  = "cpx22"
  location     = "hel1"
  firewall_ids = [hcloud_firewall.firewall.id]
  user_data = templatefile("./templates/cloud-init.yaml.tftpl", {
    traefik = templatefile("./templates/traefik.yaml.tftpl", {
      mail = var.mail
    })
    zammad = templatefile("./templates/zammad.yaml.tftpl", {
      domain = var.domain
    })
  })
  labels = {
    "app" : "zammad"
  }
  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.primary_ip_1.id
    ipv6_enabled = false
  }
}