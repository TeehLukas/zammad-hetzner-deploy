variable "hcloud_token" {
  sensitive = true
}

variable "mail" {
  description = "The Mail that is needed for the LetsEncrypt ACME Challange"
}

variable "domain" {
  description = "The Domain where Zammad is reachable"
}