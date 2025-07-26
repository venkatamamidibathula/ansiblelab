# Ansible Lab Setup - Docker-Based Learning Environment

## Overview

This repository provides a containerized Ansible learning environment that eliminates the complexity of setting up multiple virtual machines or physical servers. The setup uses Docker containers to simulate an Ansible control node (master) and multiple managed nodes (workers), making it perfect for learning, testing, and developing Ansible playbooks in a controlled environment.

## Architecture

The lab consists of:
- **Ansible Master Node**: A Docker container that acts as the Ansible control node
- **Worker Nodes**: Multiple Docker containers (worker-node1, worker-node2) that serve as managed hosts
- **Docker Compose**: Orchestrates the entire multi-container setup

## Key Features

### 🚀 **Quick Setup**
- No need for multiple VMs or physical machines
- Containerized environment reduces resource overhead
- Works on any Linux machine with Docker installed

### 🔄 **Repeatable Environment**
- Consistent setup every time
- Easy to tear down and rebuild
- Perfect for experimentation without fear of breaking things

### 📚 **Learning-Focused**
- Designed specifically for Ansible beginners
- Allows safe testing of playbooks and roles
- Provides realistic multi-node environment

## Prerequisites

Before getting started, ensure you have:

```bash
# Docker
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Setup Instructions

### Initial Setup (First Time Only)

The setup process follows a specific sequence to ensure proper networking and connectivity between containers.

#### Step 1: Start Worker Nodes First
```bash
# Start the first worker node
docker-compose up -d worker-node1

# Start the second worker node
docker-compose up -d worker-node2
```

**Why worker nodes first?** The Ansible master needs the worker nodes to be available for SSH connectivity during initialization.

#### Step 2: Verify Worker Nodes
```bash
# Check that worker nodes are running
docker-compose ps

# Expected output should show worker-node1 and worker-node2 as "Up"
```

### Running Ansible Playbooks

Once the initial setup is complete, follow these steps every time you want to run playbooks:

#### Step 1: Build the Ansible Master
```bash
docker-compose build ansible-master
```

#### Step 2: Run the Ansible Master
```bash
docker-compose run ansible-master
```

This will:
- Start the Ansible master container
- Automatically connect to the running worker nodes
- Execute any playbooks defined in your roles

## Project Structure

```
ansiblelab/
├── docker-compose.yml          # Orchestration configuration
├── Dockerfile.master          # Ansible control node image
├── Dockerfile.worker          # Managed node image
├── ansible/
│   ├── inventory/             # Host inventory files
│   ├── roles/                 # Ansible roles directory
│   │   └── your-role/         # Custom roles go here
│   ├── playbooks/             # Playbook files
│   └── ansible.cfg            # Ansible configuration
├── ssh-keys/                  # SSH key management
└── README.md
```


## Networking and Connectivity

The Docker Compose setup handles:
- **Internal networking** between containers
- **SSH key distribution** for passwordless authentication
- **DNS resolution** so containers can find each other by name
- **Port mapping** if you need to access services from the host

## Troubleshooting

### Common Issues and Solutions

#### Worker Nodes Not Responding
```bash
# Check if worker nodes are running
docker-compose ps

# Restart worker nodes if needed
docker-compose restart worker-node1 worker-node2
```

#### SSH Connection Issues
```bash
# Check SSH connectivity from master
docker-compose exec ansible-master ssh worker-node1

# Regenerate SSH keys if needed
docker-compose down
docker-compose build --no-cache
```

#### Playbook Execution Errors
```bash
# Run with maximum verbosity
ansible-playbook -i inventory/hosts playbooks/site.yml -vvvv

# Test individual modules
ansible worker-node1 -i inventory/hosts -m setup
```

## Best Practices

### 1. **Development Workflow**
- Always start worker nodes first
- Rebuild master only when you change Ansible configuration
- Use version control for your playbooks and roles

### 2. **Testing Strategy**
- Test playbooks on individual nodes first
- Use `--check` mode for dry runs
- Implement proper error handling in your roles

### 3. **Resource Management**
- Stop containers when not in use: `docker-compose down`
- Clean up unused images: `docker system prune`
- Monitor resource usage: `docker stats`


## Benefits for Learning

This setup provides several advantages for Ansible learners:

1. **Safe Environment**: Mistakes won't affect your host system
2. **Quick Reset**: Easily rebuild containers to start fresh
3. **Multi-Node Testing**: Practice with realistic infrastructure scenarios
4. **Cost-Effective**: No need for multiple VMs or cloud instances
5. **Portable**: Run the same setup on any machine with Docker

## Cleanup

When you're done working:

```bash
# Stop all containers
docker-compose down

# Remove containers and networks
docker-compose down --volumes

# Clean up images (optional)
docker system prune -a
```

## Next Steps

After mastering this lab setup, consider:
- Experimenting with different Linux distributions in worker nodes
- Integrating with CI/CD pipelines
- Scaling to more complex multi-tier applications
- Moving to cloud-based infrastructure for production learning

## Contributing

This lab setup is designed to be a learning platform. Consider:
- Adding more example roles and playbooks
- Documenting your learning experiments
- Sharing useful configurations and tips
- Creating specialized containers for specific technologies

---

**Note**: This setup is specifically designed for learning and development purposes in a home lab environment. For production use, consider proper security hardening, networking configurations, and infrastructure best practices.
