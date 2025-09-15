# Lab 1: Environment Setup and Initial Configuration

## Lab Overview
**Duration**: 60 minutes
**Difficulty**: Beginner
**Prerequisites**: Access to vSphere 8 lab environment

## Learning Objectives
- Access and navigate the vSphere 8 environment
- Verify lab infrastructure components
- Configure initial settings for training modules
- Validate connectivity and functionality

## Lab Environment
- **vCenter Server**: vcsa.lab.local
- **ESXi Hosts**: 3x ESXi 8.0 hosts
- **Storage**: Shared storage with multiple datastores
- **Network**: Multiple VLANs and port groups

## Pre-Lab Checklist
- [ ] Lab environment is powered on and accessible
- [ ] Network connectivity to lab environment verified
- [ ] Credentials provided by instructor
- [ ] Web browser with supported version

## Lab Tasks

### Task 1: Access vSphere Client (15 minutes)

#### Step 1.1: Connect to vSphere Client
1. Open web browser and navigate to: `https://vcsa.lab.local`
2. Click **"Launch vSphere Client"**
3. Enter credentials:
   - **Username**: `administrator@vsphere.local`
   - **Password**: `VMware123!`
4. Click **"Login"**

#### Step 1.2: Initial Interface Exploration
1. **Dashboard Overview**:
   - Note the main navigation menu on the left
   - Observe the dashboard widgets showing cluster health
   - Identify any alerts or warnings

2. **Inventory Navigation**:
   - Click **"Hosts and Clusters"** in the navigator
   - Expand the datacenter and cluster objects
   - Note the ESXi hosts and their status

3. **Customize Dashboard**:
   - Click the **"+"** icon to add widgets
   - Add **"Virtual Machines"** and **"Storage"** widgets
   - Arrange widgets by dragging them

#### Expected Results:
- Successfully logged into vSphere Client
- Dashboard displays cluster information
- Navigation menu is accessible and functional

### Task 2: Infrastructure Inventory (20 minutes)

#### Step 2.1: ESXi Host Analysis
1. Navigate to **"Hosts and Clusters"**
2. Select each ESXi host and record:
   - Host version and build number
   - CPU and memory specifications
   - Connection state and power state
   - Hardware vendor and model

#### Step 2.2: Storage Infrastructure
1. Click **"Storage"** in the navigator
2. For each datastore, document:
   - Datastore name and type
   - Total capacity and free space
   - Connected hosts
   - Storage protocol (NFS, iSCSI, FC)

#### Step 2.3: Network Configuration
1. Select an ESXi host
2. Go to **"Configure"** > **"Networking"**
3. Document:
   - Virtual switches and their uplinks
   - Port groups and VLAN assignments
   - VMkernel adapters and their purposes

#### Lab Worksheet:
Create a table documenting your findings:

| Component | Name | Specifications | Status |
|-----------|------|----------------|--------|
| ESXi Host 1 | | | |
| ESXi Host 2 | | | |
| ESXi Host 3 | | | |
| Datastore 1 | | | |
| Datastore 2 | | | |

### Task 3: vSphere 8 Feature Identification (15 minutes)

#### Step 3.1: New Features Discovery
1. Navigate to **"Administration"** > **"Licensing"**
2. Note the vSphere edition and available features
3. Look for vSphere 8 specific capabilities:
   - DPU support indicators
   - Enhanced security features
   - Lifecycle management improvements

#### Step 3.2: Performance Monitoring
1. Go to **"Monitor"** > **"Performance"**
2. Explore the new performance charts
3. Note any vSphere 8 specific metrics or views

### Task 4: Basic Configuration Validation (10 minutes)

#### Step 4.1: Cluster Configuration
1. Select the cluster object
2. Go to **"Configure"** > **"Services"**
3. Verify:
   - vSphere HA is enabled
   - vSphere DRS is configured
   - Admission control settings

#### Step 4.2: Time Synchronization
1. Select each ESXi host
2. Go to **"Configure"** > **"System"** > **"Time Configuration"**
3. Verify NTP is configured and synchronized

## Lab Deliverables

### Required Screenshots:
1. vSphere Client dashboard with customized widgets
2. Hosts and Clusters inventory view
3. Storage overview showing all datastores
4. Network configuration of one ESXi host

### Documentation:
1. Completed infrastructure inventory worksheet
2. List of identified vSphere 8 new features
3. Any issues encountered and resolutions

## Troubleshooting Guide

### Common Issues:

**Issue**: Cannot connect to vSphere Client
- **Solution**: Verify network connectivity, check DNS resolution, try IP address instead of FQDN

**Issue**: Login fails with provided credentials
- **Solution**: Verify caps lock, try copying credentials, contact instructor

**Issue**: Dashboard widgets not loading
- **Solution**: Refresh browser, clear cache, check browser compatibility

**Issue**: ESXi host shows as disconnected
- **Solution**: Check host power state, verify network connectivity, restart management agents

## Knowledge Validation

### Quiz Questions:
1. How many ESXi hosts are in your lab cluster?
2. What is the total storage capacity available?
3. Which vSphere 8 features did you identify?
4. What is the vCenter Server version and build?

### Practical Validation:
- Demonstrate navigation between different vSphere Client views
- Show customized dashboard with relevant widgets
- Explain the relationship between datacenter, cluster, and hosts

## Next Steps
Upon completion of this lab, you should have:
- ✅ Successfully accessed the vSphere 8 environment
- ✅ Documented the lab infrastructure
- ✅ Identified key vSphere 8 features
- ✅ Validated basic configuration

**Ready for**: [Lab 2: ESXi Host Configuration](lab-02-esxi-configuration.md)