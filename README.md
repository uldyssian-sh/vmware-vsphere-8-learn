# VMware vSphere 8 Learn

[![GitHub license](https://img.shields.io/github/license/uldyssian-sh/vmware-vsphere-8-learn)](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/blob/main/LICENSE)
[![CI](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/workflows/CI/badge.svg)](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/actions)

## 🚀 Overview

Comprehensive learning resources and hands-on labs for VMware vSphere 8. Interactive tutorials, practical examples, and certification preparation materials for vSphere 8 technologies.

**Technology Stack:** vSphere 8, PowerCLI, Terraform, Documentation, Labs

## ✨ Features

- 📚 **Learning Modules** - Structured learning paths
- 🧪 **Hands-on Labs** - Practical exercises
- 🎓 **Certification Prep** - VCP-DCV preparation
- 📖 **Documentation** - Comprehensive guides
- 💡 **Best Practices** - Industry standards
- 🔧 **Automation Examples** - PowerCLI scripts

## 🛠️ Prerequisites

- VMware Workstation/ESXi lab environment
- vCenter Server 8.0
- PowerCLI 13.0+
- Basic virtualization knowledge

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/uldyssian-sh/vmware-vsphere-8-learn.git
cd vmware-vsphere-8-learn

# Set up lab environment
./setup/deploy-lab.sh

# Start learning modules
cd modules/01-introduction
./start-module.sh
```

## 📋 Learning Modules

### Module 1: vSphere 8 Introduction
- vSphere architecture overview
- New features in vSphere 8
- Installation and configuration
- Basic administration tasks

### Module 2: vCenter Server Management
- vCenter deployment options
- Enhanced Linked Mode
- Identity and access management
- Certificate management

### Module 3: ESXi Host Management
- ESXi installation and configuration
- Host profiles and auto deploy
- Update management
- Troubleshooting techniques

### Module 4: Virtual Machine Management
- VM creation and configuration
- VM hardware features
- Guest OS optimization
- VM templates and cloning

### Module 5: Storage Management
- Storage architectures
- vSAN configuration
- Storage policies
- Performance optimization

### Module 6: Network Management
- vSphere networking concepts
- Distributed switches
- Network security
- NSX integration

### Module 7: Resource Management
- DRS and HA configuration
- Resource pools
- Performance monitoring
- Capacity planning

### Module 8: Security and Compliance
- vSphere security features
- Identity federation
- Encryption capabilities
- Compliance frameworks

## 🧪 Hands-on Labs

### Lab Environment Setup
```bash
# Deploy nested ESXi lab
./labs/setup/deploy-nested-esxi.sh

# Configure vCenter
./labs/setup/configure-vcenter.sh

# Create test workloads
./labs/setup/create-workloads.sh
```

### Practice Scenarios
- Multi-site deployment
- Disaster recovery setup
- Performance troubleshooting
- Security hardening
- Automation workflows

## 🎓 Certification Preparation

### VCP-DCV 2024 Topics
- vSphere architecture and services
- Installation, configuration, and setup
- Performance optimization
- Troubleshooting and administration
- Security and compliance

### Study Resources
- Practice exams
- Lab exercises
- Video tutorials
- Reference materials
- Study guides

## 📖 Documentation Structure

```
docs/
├── architecture/          # vSphere 8 architecture
├── installation/         # Installation guides
├── configuration/        # Configuration procedures
├── administration/       # Administrative tasks
├── troubleshooting/      # Troubleshooting guides
├── security/            # Security best practices
└── automation/          # Automation examples
```

## 🔧 Automation Examples

```powershell
# PowerCLI automation examples
Import-Module VMware.PowerCLI

# Connect to vCenter
Connect-VIServer -Server vcenter.domain.com

# Create VM from template
New-VM -Name "TestVM" -Template "Windows2022-Template" -Datastore "vSAN-Datastore"

# Configure DRS rules
New-DrsRule -Name "Anti-Affinity-Rule" -Cluster "Production" -KeepTogether:$false
```

## 📚 Additional Resources

- [VMware Documentation](https://docs.vmware.com/en/VMware-vSphere/)
- [PowerCLI Reference](https://developer.vmware.com/powercli)
- [vSphere APIs](https://developer.vmware.com/apis/vsphere-automation/)
- [Community Forums](https://communities.vmware.com/)

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.