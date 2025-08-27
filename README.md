# VMware vSphere 8 – Training Outline

**Author:** LT  
**License:** MIT  
**Duration:** 5 days  
**Audience:** System Administrators and System Engineers  

---

## Audience & Fit
This training is intended for administrators and engineers responsible for deploying, configuring, and operating VMware vSphere 8 infrastructures. It blends conceptual learning with practical lab work to enable confident management of environments from small offices to enterprise data centers.  

## Prerequisites
- Experience administering Microsoft Windows or Linux operating systems.  
- Basic knowledge of datacenter infrastructure, networking, and storage concepts.  

## Certification Path
Successful completion satisfies the training requirement for the *VMware Certified Professional – Data Center Virtualization (VCP-DCV)* certification.  

## Product Versions
- VMware ESXi 8.0  
- VMware vCenter Server 8.0  

---

# Training Syllabus

The course is delivered in ten modules across five days. Each module mixes explanations, demonstrations, and hands-on practice.

---

### Module 1 — Course Introduction
- Introductions and course logistics.  
- Review of training objectives.  

**Objective:** Establish a shared understanding of the course flow, goals, and assessment approach.  

---

### Module 2 — vSphere and Virtualization Overview
- Core virtualization concepts and vSphere’s role in the software-defined data center and cloud.  
- User interfaces for accessing vSphere.  
- How vSphere interacts with CPUs, memory, networking, storage, and GPUs.  

**Objective:** Provide a conceptual baseline and show how vSphere integrates with core infrastructure resources.  

---

### Module 3 — Installing and Configuring ESXi
- Install an ESXi host.  
- Apply ESXi user account best practices.  
- Configure ESXi host settings using DCUI and VMware Host Client.  

**Objective:** Equip learners with the ability to perform secure initial host deployments and configurations.  

---

### Module 4 — Deploying and Configuring vCenter
- Host communication with vCenter.  
- Deploy the vCenter Server Appliance.  
- Configure vCenter settings and manage license keys.  
- Create and organize inventory objects.  
- Apply permissions and interpret rules.  
- Access logs and events.  

**Objective:** Enable centralized management, role-based security, and operational monitoring of the platform.  

---

### Module 5 — Configuring vSphere Networking
- Configure and view standard switch setups.  
- Configure and view distributed switch setups.  
- Compare standard and distributed switches.  
- Apply networking policies on switches.  

**Objective:** Provide administrators with the ability to design and manage resilient virtual networks.  

---

### Module 6 — Configuring vSphere Storage
- Overview of vSphere storage technologies.  
- Identify datastore types.  
- Describe Fibre Channel and iSCSI components.  
- Configure iSCSI storage on ESXi.  
- Create and manage VMFS and NFS datastores.  

**Objective:** Prepare participants to integrate and manage diverse storage solutions for VMs.  

---

### Module 7 — Deploying Virtual Machines
- Create and provision VMs; importance of VMware Tools.  
- VM components and files.  
- Navigate VM settings in the vSphere Client.  
- Dynamically increase VM resources.  
- Templates, cloning, and customization specifications.  
- Content libraries: local, published, subscribed.  
- Deploy VMs from libraries and manage template versions.  

**Objective:** Build proficiency in VM provisioning and lifecycle management through automation and templates.  

---

### Module 8 — Managing Virtual Machines
- Types of VM migrations within and across vCenter instances.  
- vMotion and Storage vMotion; Enhanced vMotion Compatibility.  
- Snapshot creation, management, consolidation.  
- CPU and memory allocation concepts: shares, reservations, limits.  
- Understanding VM competition for resources.  

**Objective:** Teach administrators how to optimize performance, availability, and flexibility in virtualized workloads.  

---

### Module 9 — Deploying and Configuring vSphere Clusters
- Create clusters with DRS and HA.  
- View and monitor cluster information.  
- VM placement decisions with DRS and tuning settings.  
- HA response to failures and network redundancy options.  
- Fault Tolerance use cases.  

**Objective:** Enable resilient services through clustering, balancing, and fault tolerance.  

---

### Module 10 — Managing the vSphere Lifecycle
- Enable Lifecycle Manager in clusters.  
- vCenter Update Planner features and prechecks.  
- Lifecycle Manager functions.  
- Baselines vs. image-based host management.  
- Update hosts and validate compliance.  
- Automatic recommendations.  
- Upgrade VMware Tools and VM hardware.  

**Objective:** Provide structured approaches to maintain compliance, security, and currency of vSphere components.  

---

## Delivery Formats
- Classroom  
- Live online  
- Private training  
- On demand  

---

## Trainer Checklist
- Confirm lab infrastructure (ESXi, vCenter, networks, storage).  
- Prepare demo VMs and datasets.  
- Test lab steps thoroughly.  
- Ensure rollback procedures.  
- Define timeboxes per module.  

## Suggested Delivery Flow
- **Day 1:** Modules 1–2 (Introduction, overview)  
- **Day 2:** Modules 3–4 (ESXi and vCenter)  
- **Day 3:** Modules 5–6 (Networking, storage)  
- **Day 4:** Modules 7–8 (VM deployment and management)  
- **Day 5:** Modules 9–10 (Clusters and lifecycle)  

---

## Repository Layout
