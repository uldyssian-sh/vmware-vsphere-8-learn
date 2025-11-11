# VMware vSphere 8 Learning Platform

[![License](https://img.shields.io/github/license/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)](#)
[![Languages](https://img.shields.io/github/languages/count/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Size](https://img.shields.io/github/repo-size/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Security Scan](https://img.shields.io/badge/security-scanned-green?style=flat-square)](#)
[![License](https://img.shields.io/github/license/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)](#)
[![Languages](https://img.shields.io/github/languages/count/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Size](https://img.shields.io/github/repo-size/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Security Scan](https://img.shields.io/badge/security-scanned-green?style=flat-square)](#)

[![GitHub license](https://img.shields.io/github/license/uldyssian-sh/vmware-vsphere-8-learn)](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/blob/main/LICENSE)
[![CI](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/workflows/CI/badge.svg)](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/actions)
[![Security Scan](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/workflows/Security/badge.svg)](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/actions)
[![Code Quality](https://img.shields.io/badge/code%20quality-A-green)](https://github.com/uldyssian-sh/vmware-vsphere-8-learn)

## 🎯 Overview

Enterprise-grade learning platform for VMware vSphere 8 with comprehensive hands-on labs, interactive tutorials, and VCP-DCV certification preparation materials. Built with modern DevOps practices and automated CI/CD pipelines.

> 🚀 **New**: Enhanced automation scripts and improved lab exercises for 2024!

**Technology Stack:** vSphere 8.0, PowerCLI 13+, Python 3.9+, JavaScript ES6+, GitHub Actions

## ✨ Features

- 📚 **Learning Modules** - Structured learning paths
- 🧪 **Hands-on Labs** - Practical exercises
- 🎓 **Certification Prep** - VCP-DCV preparation
- 📖 **Documentation** - Comprehensive guides
- 💡 **Best Practices** - Industry standards
- 🔧 **Automation Examples** - PowerCLI scripts
- 🔒 **Security Hardening** - Enterprise-grade security
- 🛠️ **Prerequisites** - VMware Workstation/ESXi lab environment

## 🚀 Quick Start

### Prerequisites
- VMware Workstation Pro 17+ or ESXi 8.0+
- vCenter Server 8.0 (evaluation license available)
- PowerCLI 13.0+ installed
- Python 3.9+ with pip
- Git 2.30+

### Installation

```bash
# Clone repository

[![License](https://img.shields.io/github/license/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)](#)
[![Languages](https://img.shields.io/github/languages/count/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Size](https://img.shields.io/github/repo-size/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Security Scan](https://img.shields.io/badge/security-scanned-green?style=flat-square)](#)

[![License](https://img.shields.io/github/license/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)](#)
[![Languages](https://img.shields.io/github/languages/count/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Size](https://img.shields.io/github/repo-size/uldyssian-sh/vmware-vsphere-8-learn?style=flat-square)](#)
[![Security Scan](https://img.shields.io/badge/security-scanned-green?style=flat-square)](#)
git clone https://github.com/uldyssian-sh/vmware-vsphere-8-learn.git
cd vmware-vsphere-8-learn

# Install dependencies
pip install -r requirements.txt
npm install

# Validate environment
python scripts/assessment-generator.py --help
powershell -File scripts/lab-setup.ps1 -Help

# Start learning journey
cat docs/ASSESSMENT_GUIDE.md
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

**Automated Setup (Recommended)**
```powershell
# PowerCLI automated deployment
.\scripts\lab-setup.ps1 -vCenterServer "vcsa.lab.local" -LabConfig ".\configs\lab-basic.json"
```

**Manual Setup**
```bash
# Verify prerequisites
python scripts/assessment-generator.py --type practice --questions 5

# Generate lab inventory
powershell -Command "Get-VMHost | Export-Csv lab-hosts.csv"
```

### Practice Scenarios
- ✅ **Multi-site Deployment**: Cross-datacenter vSphere setup
- ✅ **Disaster Recovery**: vSphere Replication and SRM
- ✅ **Performance Optimization**: Resource management and monitoring
- ✅ **Security Hardening**: CIS benchmarks and compliance
- ✅ **Automation Workflows**: PowerCLI and REST API integration

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
vmware-vsphere-8-learn/
├── 📁 docs/
│   ├── ASSESSMENT_GUIDE.md     # Assessment methodology
│   └── INSTRUCTOR_GUIDE.md     # Teaching guidelines
├── 📁 modules/
│   ├── 01-introduction/        # vSphere 8 fundamentals
│   └── 02-esxi-deployment/     # ESXi installation & config
├── 📁 labs/
│   └── lab-01-environment-setup.md
├── 📁 scripts/
│   ├── assessment-generator.py  # Automated assessments
│   └── lab-setup.ps1           # Lab environment setup
├── 📁 tests/
│   └── content-validation.tests.ps1
└── 📁 assets/
    └── scripts/
        └── progress-tracker.js  # Learning progress tracking
```

## 🔧 Automation Examples

### PowerCLI Automation
```powershell
# Import required modules
Import-Module VMware.PowerCLI -Force

# Secure connection to vCenter
$credential = Get-Credential
Connect-VIServer -Server "vcenter.lab.local" -Credential $credential

# Automated VM deployment
$vmConfig = @{
    Name = "Lab-VM-$(Get-Date -Format 'yyyyMMdd-HHmm')"
    Template = "Ubuntu-22.04-Template"
    Datastore = "vSAN-Datastore"
    ResourcePool = "Lab-Resources"
}
New-VM @vmConfig

# Configure HA/DRS cluster
New-Cluster -Name "Lab-Cluster" -Location (Get-Datacenter "Lab-DC") -HAEnabled -DrsEnabled
```

### Python API Integration
```python
# vSphere REST API automation
from scripts.assessment_generator import AssessmentGenerator

# Generate practice assessment
generator = AssessmentGenerator()
assessment = generator.generate_assessment(
    assessment_type="practice",
    modules=["introduction", "esxi-deployment"],
    num_questions=10
)

# Export to multiple formats
generator.export_assessment(assessment, "html")
generator.export_assessment(assessment, "json")
```

## 📚 Resources & References

### Official VMware Documentation
- 📖 [vSphere 8.0 Documentation](https://docs.vmware.com/en/VMware-vSphere/8.0/)
- 🔧 [PowerCLI Developer Guide](https://developer.vmware.com/powercli)
- 🌐 [vSphere REST API Reference](https://developer.vmware.com/apis/vsphere-automation/)
- 📋 [Hardware Compatibility Guide](https://www.vmware.com/resources/compatibility/)

### Learning Resources
- 🎓 [VMware Learning Platform](https://www.vmware.com/education-services/)
- 👥 [VMware Community Forums](https://communities.vmware.com/)
- 📺 [VMware Tech Zone](https://techzone.vmware.com/)
- 📊 [vSphere Performance Guide](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-resource-management/)

### Certification Preparation
- 🏆 [VCP-DCV Certification](https://www.vmware.com/education-services/certification/vcp-dcv.html)
- 📝 [VMware Education](https://www.vmware.com/education-services/)
- 🔍 [Hands-on Labs](https://labs.hol.vmware.com/)

## 🔒 Security & Compliance

- ✅ **Automated Security Scanning**: CodeQL, Dependabot, and vulnerability assessments
- ✅ **Code Quality**: ESLint, Prettier, and automated testing
- ✅ **Free Tier Optimized**: 100% GitHub Free tier compliant
- ✅ **No Sensitive Data**: All credentials and personal information sanitized

## 🤝 Contributing

Contributions welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Contributors
- **actions-user** - Automated CI/CD workflows
- **dependabot[bot]** - Dependency management
- **uldyssian-sh** - Platform development and maintenance

## 📊 Project Status

- ✅ **CI/CD Pipeline**: Fully automated with GitHub Actions
- ✅ **Security Compliance**: Regular vulnerability scans
- ✅ **Documentation**: Comprehensive and up-to-date
- ✅ **Testing**: Automated validation and quality checks

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

**Repository**: [uldyssian-sh/vmware-vsphere-8-learn](https://github.com/uldyssian-sh/vmware-vsphere-8-learn)  
**Issues**: [Report bugs or request features](https://github.com/uldyssian-sh/vmware-vsphere-8-learn/issues)
# CodeQL trigger Sun Oct 12 16:29:10 CEST 2025
