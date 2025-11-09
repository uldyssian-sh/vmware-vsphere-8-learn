#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Automated lab setup script for vSphere 8 training environment
.DESCRIPTION
    Configures and validates vSphere 8 lab environment for training modules
.PARAMETER vCenterServer
    vCenter Server FQDN or IP address
.PARAMETER Credential
    PSCredential for vCenter authentication
.PARAMETER LabConfig
    Path to lab configuration file
.EXAMPLE
    .\lab-setup.ps1 -vCenterServer vcsa.lab.local -LabConfig .\configs\lab-basic.json
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$vCenterServer,
    
    [PSCredential]$Credential,
    
    [string]$LabConfig = ".\configs\lab-default.json"
)

$ErrorActionPreference = 'Stop'

# Import required modules
$requiredModules = @('VMware.VimAutomation.Core', 'VMware.VimAutomation.Storage')
foreach ($module in $requiredModules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Write-Warning "Module $module not found. Install VMware PowerCLI first."
        Write-Host "Install-Module VMware.PowerCLI -Scope CurrentUser" -ForegroundColor Yellow
        exit 1
    }
    Import-Module $module -Force
}

function Write-LabLog {
    param([string]$Message, [string]$Level = 'Info')
    $timestamp = Get-Date -Format 'HH:mm:ss'
    $color = switch ($Level) {
        'Error' { 'Red' }
        'Warning' { 'Yellow' }
        'Success' { 'Green' }
        default { 'Cyan' }
    }
    Write-Host "[$timestamp] $Message" -ForegroundColor $color
}

function Test-LabPrerequisites {
    Write-LabLog "Checking lab prerequisites..."
    
    # Check PowerCLI version
    $powerCLI = Get-Module VMware.PowerCLI -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1
    if ($powerCLI.Version -lt [version]"13.0.0") {
        throw "PowerCLI 13.0+ required. Current: $($powerCLI.Version)"
    }
    
    # Check lab config file
    if (-not (Test-Path $LabConfig)) {
        throw "Lab configuration file not found: $LabConfig"
    }
    
    Write-LabLog "Prerequisites validated" -Level Success
}

function Connect-LabvCenter {
    Write-LabLog "Connecting to vCenter: $vCenterServer"
    
    try {
        if ($Credential) {
            Connect-VIServer -Server $vCenterServer -Credential $Credential -ErrorAction Stop | Out-Null
        } else {
            Connect-VIServer -Server $vCenterServer -ErrorAction Stop | Out-Null
        }
        Write-LabLog "Connected successfully" -Level Success
    }
    catch {
        throw "Failed to connect to vCenter: $_"
    }
}

function Initialize-LabEnvironment {
    param([hashtable]$Config)
    
    Write-LabLog "Initializing lab environment..."
    
    # Create datacenter if not exists
    $datacenter = Get-Datacenter -Name $Config.Datacenter -ErrorAction SilentlyContinue
    if (-not $datacenter) {
        Write-LabLog "Creating datacenter: $($Config.Datacenter)"
        $datacenter = New-Datacenter -Location (Get-Folder -NoRecursion) -Name $Config.Datacenter
    }
    
    # Create cluster if not exists
    $cluster = Get-Cluster -Name $Config.Cluster -ErrorAction SilentlyContinue
    if (-not $cluster) {
        Write-LabLog "Creating cluster: $($Config.Cluster)"
        $cluster = New-Cluster -Location $datacenter -Name $Config.Cluster -HAEnabled:$Config.HAEnabled -DrsEnabled:$Config.DrsEnabled
    }
    
    Write-LabLog "Lab environment initialized" -Level Success
    return @{
        Datacenter = $datacenter
        Cluster = $cluster
    }
}

function Test-LabConnectivity {
    Write-LabLog "Testing lab connectivity..."
    
    # Test ESXi hosts
    $hosts = Get-VMHost
    foreach ($vmhost in $hosts) {
        $connectionState = $vmhost.ConnectionState
        if ($connectionState -eq 'Connected') {
            Write-LabLog "✓ Host $($vmhost.Name): $connectionState" -Level Success
        } else {
            Write-LabLog "✗ Host $($vmhost.Name): $connectionState" -Level Warning
        }
    }
    
    # Test datastores
    $datastores = Get-Datastore
    foreach ($ds in $datastores) {
        $freeSpaceGB = [math]::Round($ds.FreeSpaceGB, 2)
        Write-LabLog "✓ Datastore $($ds.Name): ${freeSpaceGB}GB free"
    }
}

function Export-LabInventory {
    Write-LabLog "Exporting lab inventory..."
    
    $inventory = @{
        vCenter = $global:DefaultVIServer.Name
        Timestamp = Get-Date
        Hosts = Get-VMHost | Select-Object Name, Version, Build, ConnectionState, PowerState
        Clusters = Get-Cluster | Select-Object Name, HAEnabled, DrsEnabled, HAFailoverLevel
        Datastores = Get-Datastore | Select-Object Name, Type, CapacityGB, FreeSpaceGB
        Networks = Get-VirtualPortGroup | Select-Object Name, VLanId, VirtualSwitch
    }
    
    $outputPath = "lab-inventory-$(Get-Date -Format 'yyyyMMdd-HHmmss').json"
    $inventory | ConvertTo-Json -Depth 3 | Set-Content -Path $outputPath
    Write-LabLog "Inventory exported to: $outputPath" -Level Success
}

# Main execution
try {
    Write-LabLog "Starting vSphere 8 lab setup..." -Level Success
    
    Test-LabPrerequisites
    Connect-LabvCenter
    
    # Load lab configuration
    $config = Get-Content $LabConfig | ConvertFrom-Json -AsHashtable
    
    # Initialize environment
    $labEnv = Initialize-LabEnvironment -Config $config
    
    # Test connectivity
    Test-LabConnectivity
    
    # Export inventory
    Export-LabInventory
    
    Write-LabLog "Lab setup completed successfully!" -Level Success
    Write-LabLog "Environment ready for vSphere 8 training modules" -Level Success
}
catch {
    Write-LabLog "Lab setup failed: $_" -Level Error
    exit 1
}
finally {
    if (Get-VIServer -ErrorAction SilentlyContinue) {
        Disconnect-VIServer -Confirm:$false
    }
}# Updated Sun Nov  9 12:52:43 CET 2025
# Updated Sun Nov  9 12:55:59 CET 2025
