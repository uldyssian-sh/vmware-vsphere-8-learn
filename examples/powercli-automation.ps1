#!/usr/bin/env pwsh
<#
.SYNOPSIS
    PowerCLI automation examples for vSphere 8 training
.DESCRIPTION
    Collection of practical PowerCLI scripts demonstrating common vSphere 8 automation tasks
.NOTES
    Author: VMware Training Team
    Version: 1.0
    Requires: PowerCLI 13.0+, vSphere 8.0+
#>

#region Connection Management
function Connect-TrainingvCenter {
    <#
    .SYNOPSIS
        Secure connection to training vCenter
    .EXAMPLE
        Connect-TrainingvCenter -Server vcsa.lab.local
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Server,
        
        [PSCredential]$Credential
    )
    
    try {
        if ($Credential) {
            Connect-VIServer -Server $Server -Credential $Credential -ErrorAction Stop
        } else {
            Connect-VIServer -Server $Server -ErrorAction Stop
        }
        Write-Host "✓ Connected to vCenter: $Server" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to connect to vCenter: $_"
        throw
    }
}
#endregion

#region VM Management Examples
function New-TrainingVM {
    <#
    .SYNOPSIS
        Creates a new VM with standard training configuration
    .EXAMPLE
        New-TrainingVM -Name "Student-VM-01" -Template "Windows-2022-Template"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        
        [Parameter(Mandatory)]
        [string]$Template,
        
        [string]$Datastore = "datastore1",
        [string]$Cluster = "Training-Cluster",
        [int]$MemoryGB = 4,
        [int]$NumCpu = 2
    )
    
    try {
        Write-Host "Creating VM: $Name" -ForegroundColor Yellow
        
        $vmTemplate = Get-Template -Name $Template -ErrorAction Stop
        $targetCluster = Get-Cluster -Name $Cluster -ErrorAction Stop
        $targetDatastore = Get-Datastore -Name $Datastore -ErrorAction Stop
        
        $vm = New-VM -Name $Name -Template $vmTemplate -Location $targetCluster -Datastore $targetDatastore
        
        # Configure VM specifications
        $vm | Set-VM -MemoryGB $MemoryGB -NumCpu $NumCpu -Confirm:$false
        
        Write-Host "✓ VM created successfully: $Name" -ForegroundColor Green
        return $vm
    }
    catch {
        Write-Error "Failed to create VM: $_"
        throw
    }
}

function Get-VMInventoryReport {
    <#
    .SYNOPSIS
        Generates comprehensive VM inventory report
    .EXAMPLE
        Get-VMInventoryReport | Export-Csv -Path "vm-inventory.csv"
    #>
    [CmdletBinding()]
    param()
    
    Write-Host "Generating VM inventory report..." -ForegroundColor Yellow
    
    Get-VM | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.Name
            PowerState = $_.PowerState
            NumCpu = $_.NumCpu
            MemoryGB = $_.MemoryGB
            ProvisionedSpaceGB = [math]::Round($_.ProvisionedSpaceGB, 2)
            UsedSpaceGB = [math]::Round($_.UsedSpaceGB, 2)
            Host = $_.VMHost.Name
            Cluster = $_.VMHost.Parent.Name
            Datastore = ($_ | Get-Datastore | Select-Object -First 1).Name
            GuestOS = $_.Guest.OSFullName
            VMwareTools = $_.Guest.ToolsStatus
            IPAddress = $_.Guest.IPAddress[0]
            Created = $_.CreateDate
        }
    }
}
#endregion

#region Host Management Examples
function Get-ESXiHealthReport {
    <#
    .SYNOPSIS
        Generates ESXi host health report
    .EXAMPLE
        Get-ESXiHealthReport | Format-Table -AutoSize
    #>
    [CmdletBinding()]
    param()
    
    Write-Host "Generating ESXi health report..." -ForegroundColor Yellow
    
    Get-VMHost | ForEach-Object {
        $vmhost = $_
        $hardware = $vmhost | Get-View | Select-Object -ExpandProperty Hardware
        
        [PSCustomObject]@{
            Name = $vmhost.Name
            Version = $vmhost.Version
            Build = $vmhost.Build
            ConnectionState = $vmhost.ConnectionState
            PowerState = $vmhost.PowerState
            CPUModel = $hardware.CpuInfo.CpuPackage[0].Description
            CPUCores = $vmhost.NumCpu
            MemoryGB = [math]::Round($vmhost.MemoryTotalGB, 2)
            MemoryUsageGB = [math]::Round($vmhost.MemoryUsageGB, 2)
            UptimeDays = [math]::Round($vmhost.UptimeSeconds / 86400, 1)
            MaintenanceMode = $vmhost.State -eq 'Maintenance'
            Cluster = $vmhost.Parent.Name
        }
    }
}

function Set-ESXiNTPConfiguration {
    <#
    .SYNOPSIS
        Configures NTP on all ESXi hosts
    .EXAMPLE
        Set-ESXiNTPConfiguration -NTPServers @("pool.ntp.org", "time.google.com")
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string[]]$NTPServers
    )
    
    Write-Host "Configuring NTP on ESXi hosts..." -ForegroundColor Yellow
    
    Get-VMHost | ForEach-Object {
        $vmhost = $_
        Write-Host "Configuring NTP on: $($vmhost.Name)" -ForegroundColor Cyan
        
        try {
            # Remove existing NTP servers
            Get-VMHostNtpServer -VMHost $vmhost | Remove-VMHostNtpServer -VMHost $vmhost -Confirm:$false
            
            # Add new NTP servers
            foreach ($ntpServer in $NTPServers) {
                Add-VMHostNtpServer -VMHost $vmhost -NtpServer $ntpServer
            }
            
            # Configure NTP service
            $ntpService = Get-VMHostService -VMHost $vmhost | Where-Object {$_.Key -eq "ntpd"}
            Set-VMHostService -HostService $ntpService -Policy "on"
            Start-VMHostService -HostService $ntpService
            
            Write-Host "✓ NTP configured on: $($vmhost.Name)" -ForegroundColor Green
        }
        catch {
            Write-Warning "Failed to configure NTP on $($vmhost.Name): $_"
        }
    }
}
#endregion

#region Storage Management Examples
function Get-DatastoreUtilizationReport {
    <#
    .SYNOPSIS
        Generates datastore utilization report with alerts
    .EXAMPLE
        Get-DatastoreUtilizationReport -WarningThreshold 80 -CriticalThreshold 90
    #>
    [CmdletBinding()]
    param(
        [int]$WarningThreshold = 80,
        [int]$CriticalThreshold = 90
    )
    
    Write-Host "Generating datastore utilization report..." -ForegroundColor Yellow
    
    Get-Datastore | ForEach-Object {
        $datastore = $_
        $utilizationPercent = [math]::Round((($datastore.CapacityGB - $datastore.FreeSpaceGB) / $datastore.CapacityGB) * 100, 2)
        
        $alertLevel = if ($utilizationPercent -ge $CriticalThreshold) { "CRITICAL" }
                     elseif ($utilizationPercent -ge $WarningThreshold) { "WARNING" }
                     else { "OK" }
        
        [PSCustomObject]@{
            Name = $datastore.Name
            Type = $datastore.Type
            CapacityGB = [math]::Round($datastore.CapacityGB, 2)
            FreeSpaceGB = [math]::Round($datastore.FreeSpaceGB, 2)
            UtilizationPercent = $utilizationPercent
            AlertLevel = $alertLevel
            ConnectedHosts = ($datastore | Get-VMHost).Count
            VMCount = ($datastore | Get-VM).Count
        }
    }
}

function New-VMDiskExpansion {
    <#
    .SYNOPSIS
        Expands VM disk and extends partition (Windows)
    .EXAMPLE
        New-VMDiskExpansion -VM "TestVM" -DiskNumber 1 -NewSizeGB 100
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$VMName,
        
        [Parameter(Mandatory)]
        [int]$DiskNumber,
        
        [Parameter(Mandatory)]
        [int]$NewSizeGB
    )
    
    try {
        $vm = Get-VM -Name $VMName -ErrorAction Stop
        $harddisk = $vm | Get-HardDisk | Where-Object {$_.Name -eq "Hard disk $DiskNumber"}
        
        if (-not $harddisk) {
            throw "Hard disk $DiskNumber not found on VM $VMName"
        }
        
        Write-Host "Expanding disk $DiskNumber on VM: $VMName to ${NewSizeGB}GB" -ForegroundColor Yellow
        
        # Expand the virtual disk
        Set-HardDisk -HardDisk $harddisk -CapacityGB $NewSizeGB -Confirm:$false
        
        Write-Host "✓ Disk expanded successfully. Guest OS partition extension may be required." -ForegroundColor Green
        Write-Host "  For Windows: Use Disk Management or diskpart" -ForegroundColor Cyan
        Write-Host "  For Linux: Use fdisk/parted and resize2fs/xfs_growfs" -ForegroundColor Cyan
    }
    catch {
        Write-Error "Failed to expand disk: $_"
        throw
    }
}
#endregion

#region Network Management Examples
function New-DistributedPortGroup {
    <#
    .SYNOPSIS
        Creates a new distributed port group with standard configuration
    .EXAMPLE
        New-DistributedPortGroup -Name "VLAN-100-Web" -VLanId 100 -VDSwitch "Training-VDS"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        
        [Parameter(Mandatory)]
        [int]$VLanId,
        
        [Parameter(Mandatory)]
        [string]$VDSwitchName,
        
        [int]$NumPorts = 128
    )
    
    try {
        $vdSwitch = Get-VDSwitch -Name $VDSwitchName -ErrorAction Stop
        
        Write-Host "Creating distributed port group: $Name" -ForegroundColor Yellow
        
        $portGroup = New-VDPortgroup -VDSwitch $vdSwitch -Name $Name -NumPorts $NumPorts
        $portGroup | Get-VDPortgroupOverridePolicy | Set-VDPortgroupOverridePolicy -VlanOverrideAllowed $true
        $portGroup | Set-VDPortgroup -VlanId $VLanId
        
        Write-Host "✓ Port group created: $Name (VLAN $VLanId)" -ForegroundColor Green
        return $portGroup
    }
    catch {
        Write-Error "Failed to create port group: $_"
        throw
    }
}

function Get-NetworkConfigurationReport {
    <#
    .SYNOPSIS
        Generates network configuration report for all hosts
    .EXAMPLE
        Get-NetworkConfigurationReport | Export-Csv -Path "network-config.csv"
    #>
    [CmdletBinding()]
    param()
    
    Write-Host "Generating network configuration report..." -ForegroundColor Yellow
    
    $results = @()
    
    Get-VMHost | ForEach-Object {
        $vmhost = $_
        
        # Get virtual switches
        Get-VirtualSwitch -VMHost $vmhost | ForEach-Object {
            $vswitch = $_
            
            $results += [PSCustomObject]@{
                Host = $vmhost.Name
                Type = "vSwitch"
                Name = $vswitch.Name
                Uplinks = ($vswitch | Get-VMHostNetworkAdapter | Where-Object {$_.Type -eq "PhysicalNic"}).Name -join ", "
                PortGroups = ($vswitch | Get-VirtualPortGroup).Name -join ", "
                MTU = $vswitch.Mtu
            }
        }
        
        # Get VMkernel adapters
        Get-VMHostNetworkAdapter -VMHost $vmhost -VMKernel | ForEach-Object {
            $vmk = $_
            
            $results += [PSCustomObject]@{
                Host = $vmhost.Name
                Type = "VMkernel"
                Name = $vmk.Name
                IPAddress = $vmk.IP
                SubnetMask = $vmk.SubnetMask
                PortGroup = $vmk.PortGroupName
                Services = ($vmk | Get-VMHostNetworkAdapterVMotionEnabled, 
                           $vmk | Get-VMHostNetworkAdapterManagementEnabled) -join ", "
            }
        }
    }
    
    return $results
}
#endregion

#region Automation Examples
function Start-VMMaintenanceWorkflow {
    <#
    .SYNOPSIS
        Automated maintenance workflow for VMs
    .EXAMPLE
        Start-VMMaintenanceWorkflow -VMName "WebServer-01" -MaintenanceType "Patch"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$VMName,
        
        [ValidateSet("Patch", "Backup", "Snapshot")]
        [string]$MaintenanceType = "Patch"
    )
    
    try {
        $vm = Get-VM -Name $VMName -ErrorAction Stop
        
        Write-Host "Starting maintenance workflow for: $VMName" -ForegroundColor Yellow
        
        # Step 1: Create pre-maintenance snapshot
        Write-Host "Creating pre-maintenance snapshot..." -ForegroundColor Cyan
        $snapshot = New-Snapshot -VM $vm -Name "Pre-$MaintenanceType-$(Get-Date -Format 'yyyyMMdd-HHmm')" -Memory:$false
        
        # Step 2: Shutdown VM gracefully
        Write-Host "Shutting down VM gracefully..." -ForegroundColor Cyan
        if ($vm.PowerState -eq "PoweredOn") {
            Shutdown-VMGuest -VM $vm -Confirm:$false
            
            # Wait for shutdown with timeout
            $timeout = 300 # 5 minutes
            $timer = 0
            while ($vm.PowerState -eq "PoweredOn" -and $timer -lt $timeout) {
                Start-Sleep -Seconds 10
                $timer += 10
                $vm = Get-VM -Name $VMName
            }
            
            if ($vm.PowerState -eq "PoweredOn") {
                Write-Warning "Graceful shutdown failed, forcing power off"
                Stop-VM -VM $vm -Confirm:$false
            }
        }
        
        # Step 3: Perform maintenance action
        switch ($MaintenanceType) {
            "Patch" {
                Write-Host "Maintenance window ready for patching" -ForegroundColor Green
                Write-Host "Apply patches now, then run: Complete-VMMaintenanceWorkflow -VMName $VMName" -ForegroundColor Yellow
            }
            "Backup" {
                Write-Host "VM ready for backup operations" -ForegroundColor Green
            }
            "Snapshot" {
                Write-Host "Additional snapshot created for maintenance" -ForegroundColor Green
            }
        }
        
        return @{
            VM = $vm
            Snapshot = $snapshot
            MaintenanceType = $MaintenanceType
            StartTime = Get-Date
        }
    }
    catch {
        Write-Error "Maintenance workflow failed: $_"
        throw
    }
}

function Complete-VMMaintenanceWorkflow {
    <#
    .SYNOPSIS
        Completes VM maintenance workflow
    .EXAMPLE
        Complete-VMMaintenanceWorkflow -VMName "WebServer-01"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$VMName,
        
        [switch]$RemoveSnapshot
    )
    
    try {
        $vm = Get-VM -Name $VMName -ErrorAction Stop
        
        Write-Host "Completing maintenance workflow for: $VMName" -ForegroundColor Yellow
        
        # Power on VM
        if ($vm.PowerState -eq "PoweredOff") {
            Write-Host "Powering on VM..." -ForegroundColor Cyan
            Start-VM -VM $vm
        }
        
        # Wait for VMware Tools
        Write-Host "Waiting for VMware Tools..." -ForegroundColor Cyan
        Wait-Tools -VM $vm -TimeoutSeconds 300
        
        # Remove snapshot if requested
        if ($RemoveSnapshot) {
            $snapshots = Get-Snapshot -VM $vm | Where-Object {$_.Name -like "Pre-*"}
            if ($snapshots) {
                Write-Host "Removing maintenance snapshots..." -ForegroundColor Cyan
                $snapshots | Remove-Snapshot -Confirm:$false
            }
        }
        
        Write-Host "✓ Maintenance workflow completed for: $VMName" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to complete maintenance workflow: $_"
        throw
    }
}
#endregion

# Example usage and demonstrations
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host @"
PowerCLI Automation Examples for vSphere 8 Training

Available Functions:
- Connect-TrainingvCenter: Secure vCenter connection
- New-TrainingVM: Create standardized training VMs
- Get-VMInventoryReport: Comprehensive VM inventory
- Get-ESXiHealthReport: ESXi host health status
- Set-ESXiNTPConfiguration: Configure NTP on all hosts
- Get-DatastoreUtilizationReport: Storage utilization analysis
- New-VMDiskExpansion: Expand VM disks
- New-DistributedPortGroup: Create distributed port groups
- Get-NetworkConfigurationReport: Network configuration audit
- Start-VMMaintenanceWorkflow: Automated maintenance procedures
- Complete-VMMaintenanceWorkflow: Complete maintenance tasks

Example Usage:
Connect-TrainingvCenter -Server vcsa.lab.local
Get-VMInventoryReport | Format-Table -AutoSize
Get-ESXiHealthReport | Where-Object {$_.ConnectionState -ne 'Connected'}

"@ -ForegroundColor Green
}