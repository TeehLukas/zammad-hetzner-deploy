# Zammad Deployment with Terraform and Docker

## Overview

This repository provides Infrastructure as Code (IaC) for deploying a Zammad helpdesk instance on Hetzner Cloud using Terraform and Docker. The deployment includes automated SSL certificate management via Let's Encrypt and reverse proxy configuration with Traefik.

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Hetzner Cloud │    │   Traefik       │    │   Zammad        │
│   Server        │───▶│   Reverse Proxy │───▶│   Docker        │
│                 │    │                 │    │   Container     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Requirements

### Hardware
- Hetzner Cloud server (cpx22 minimum)
- Ubuntu 24.04 LTS

### Software
- Terraform 1.0+
- Docker
- Git

## Deployment Process

### 1. Prerequisites
```bash
# Clone repository
git clone <repository-url>
cd Deployment

# Create configuration file
vim terraform.tfvars
```

### 2. Configuration
Edit `terraform.tfvars`:
```hcl
hcloud_token = "your_hetzner_api_token"
mail = "admin@example.com"
domain = "zammad.example.com"
```

### 3. Deployment
```bash
terraform init
terraform plan
terraform apply
```

## Components

### Cloud-init Configuration
- Docker installation
- UFW firewall setup
- System hardening
- fail2ban configuration

### Traefik Reverse Proxy
- Automatic SSL certificate provisioning via Let's Encrypt
- HTTP to HTTPS redirection
- Load balancing configuration

### Zammad Container
- PostgreSQL database
- Redis cache
- Application server
- Web interface

## Security Features

- UFW firewall with restricted ports (80, 443)
- System hardening via sysctl configuration
- SSH access disabled
- Automatic security updates
- fail2ban for brute-force protection

## Variables

| Variable      | Description                              | Required |
|---------------|------------------------------------------|----------|
| `hcloud_token`| Hetzner Cloud API token                  | Yes      |
| `mail`        | Email for Let's Encrypt ACME challenge   | Yes      |
| `domain`      | Domain name for Zammad instance          | Yes      |

## File Structure

```
Deployment/
├── main.tf              # Main Terraform configuration
├── provider.tf          # Provider configuration
├── variables.tf         # Variable definitions
├── terraform.tfvars     # Variable values
├── templates/
│   ├── cloud-init.yaml.tftpl   # Cloud-init configuration
│   ├── traefik.yaml.tftpl      # Traefik configuration
│   └── zammad.yaml.tftpl       # Zammad configuration
└── README.md            # Documentation
```

## Access

After deployment:
- Web interface: `https://<domain>`
- Default credentials: `admin@localhost.local` / `admin`

## Maintenance

### Updates
- Automatic updates enabled via cloud-init
- Manual updates: `docker-compose pull && docker-compose up -d`

### Monitoring
- System logs: `/var/log/syslog`
- Traefik logs: `/var/log/traefik/`
- Zammad logs: `docker logs zammad-app`

## Troubleshooting

### Common Issues
1. **SSL Certificate Errors**: Verify DNS records and email configuration
2. **Port Conflicts**: Ensure ports 80/443 are available
3. **Container Failures**: Check Docker logs with `docker logs <container>`

### Debugging
```bash
# Check container status
docker ps -a

# View logs
docker logs traefik
docker logs zammad-app

# Verify network connectivity
curl -v http://localhost
```

