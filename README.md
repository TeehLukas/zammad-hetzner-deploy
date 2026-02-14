# Hetzner Cloud: Zammad Infrastructure with Terraform

This project automates the deployment of a **Zammad Ticketing System** on Hetzner Cloud. It uses Terraform to provision the infrastructure and `cloud-init` to bootstrap Docker, Traefik, and Zammad.



##  Infrastructure Overview

| Resource | Specification | Purpose |
| :--- | :--- | :--- |
| **Server** | `cpx22` Instance | Compute node for Docker-based Zammad & Traefik. |
| **OS** | Ubuntu 24.04 LTS | Modern and stable base operating system. |
| **Primary IP** | IPv4 ( Helsinki `hel1`) | Dedicated public address for DNS mapping. |
| **Firewall** | Ports 80 & 443 | Security: Only Web traffic (HTTP/HTTPS) is allowed. |

---

##  Configuration (`terraform.tfvars`)

Create a `terraform.tfvars` file in the root directory to store your credentials and domain settings:

```hcl
# Hetzner API Token
hcloud_token = "YOUR_HCLOUD_API_TOKEN"

# Let's Encrypt / Application Config
mail   = "admin@your-domain.com"
domain = "tickets.your-domain.com"
```
