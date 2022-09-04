# Automate VMWare desktop Creation process
# Tested - vCenter 7.2
# for more indepth information please visit https://github.com/vmware/PowerCLI-Example-Scripts/tree/master/Modules/VMware.Hv.Helper.
# Custmized script written by: Fazmin Nizam
# This will create pools based on the Selected golden images make sure to add the required data prior executingt the script.
# Things to do: Add option to email admin when each of the process is done, Create a log fileof the process and attach it to the email

#vCenter Credentials
$Cred = Get-Credential

#Global Settings
$HVServer = "<Horizon View Server>"
$Vcenter = "<vCenter Server>"
$datacenter = "<Your Datacenter>"
$datastore = "<Your Datsastore>"
$DomainAdmin = "<Your Instant Clone Domain Admin>"
$HostOrCluster = "<Your Cluster>"
$ResourcePool = "<Resourcepool path>"
$NetBiosName = "<Your NETBIOS>"
$ParentVM = "<Name of ParentVM>"
$SnapshotVM = "<Name of Snapshot VM>"

#Select Environment
$Environment = "<Env Name>" # or STUDENT or POC

If ($environment -eq "PRODUCTION")
    {
        $PoolName = "PRODUCTION"
        $PoolDisplayName = "PRODUCTION"
        $ProvTime = "UP_FRONT"
        $VmFolder  = "</DATASTORE/FOLDER>"
        $MinimumCount = 1
        $MaximumCount = 5
        $SpareCount = 1
        $NumUnassignedMachinesKeptPoweredOn = 1
        $AdContainer = "OU=PRODUCTION,OU=VIRTUAL DESKTOPS"
    }

If ($environment -eq "TEST")
    {
        $PoolName = "TEST"
        $PoolDisplayName = "TEST"
        $ProvTime = "UP_FRONT"
        $VmFolder  = "</DATASTORE/FOLDER>"
        $MinimumCount = 1
        $MaximumCount = 5
        $SpareCount = 1
        $NumUnassignedMachinesKeptPoweredOn = 1
        $AdContainer = "OU=TEST,OU=VIRTUAL DESKTOPS"
    }   
    
If ($environment -eq "PROOFOFCONCEPT")
    {
        $PoolName = "PROOFOFCONCEPT"
        $PoolDisplayName = "PROOFOFCONCEPT"
        $ProvTime = "UP_FRONT"
        $VmFolder  = "</DATASTORE/FOLDER> "
        $MinimumCount = 1
        $MaximumCount = 5
        $SpareCount = 1
        $NumUnassignedMachinesKeptPoweredOn = 1
        $AdContainer = "OU=PROOFOFCONCEPT,OU=VIRTUAL DESKTOPS"
    }       



#Generic Horizon Settings
# $NamingPattern = "VDI-$($PoolName)-{n:fixed=3}" # for example
$NamingPattern = "Pool-C-VM-{n:fixed=3}" # for example
$UserAssignment = "FLOATING" # or DEDICATED
$AutomaticAssignment = $true # or $false
$allowUsersToResetMachines = $false # or $true
$AllowMultipleSessionsPerUser = $false # or $true
$deleteOrRefreshMachineAfterLogoff = "NEVER" # DELETE or NEVER -lof
$RefreshOsDiskAfterLogoff = "NEVER"
$supportedDisplayProtocols = "BLAST","PCOIP"
$renderer3D = "ENABELED"
$quality = "NO_CONTROL" #or HIGH LOW MEDIUM
$throttling = "DISABLED" #or AGGRESIVE CONSERVATIVE DISABLED MODERATE
$overrideGlobalSetting = $false # or $true
$UseSeparateDatastoresReplicaAndOSDisks = $false # or $true
$UseViewStorageAccelerator = $false # or $true
$EnableProvisioning = $true # or $false
$NamingMethod = "PATTERN"
$ReclaimVmDiskSpace = $false # or $true
$RedirectWindowsProfile = $false # or $true 
$StopOnProvisioningError = $true # or $true
$StorageOvercommit = "UNBOUNDED"
$enableGRIDvGPUs = $true
$maxNumberOfMonitors = 2
$UseVSAN = $true # or $false
$enableHTMLAccess = $true # or $false
$defaultDisplayProtocol = "BLAST"
$maxResolutionOfAnyOneMonitor = "WUXGA"
$UseNativeSnapshots = $false # or $true
$UseSeparateDatastoresPersistentAndOSDisks = $false # or $true
$AutomaticLogoffMinutes = 10 #0 FOR NONE
$allowUsersToChooseProtocol = 1
$AutomaticLogoffPolicy = "AFTER" #IMMEDIATELY or NEVER
$postsyncscript = ""
$postsyncpara = ""

#Connect to Horizon Connection Server
Connect-HVServer -Server $HVServer -Credential $Cred

#Create Pool Process
New-HVPool -instantclone `
            -Datastores $Datastores `
            -HostOrCluster $HostOrCluster `
            -NamingMethod $NamingMethod `
            -NetBiosName $NetBiosName `
            -ParentVM $ParentVM `
            -PoolName $NewPoolName `
            -ResourcePool $ResourcePool `
            -SnapshotVM $SnapshotVM `
            -UserAssignment $UserAssignment `
            -VmFolder $VmFolder `
            -AdContainer $AdContainer `
            -AutomaticAssignment $AutomaticAssignment `
            -datacenter $datacenter `
            -DomainAdmin $DomainAdmin `
            -Enable $true `
            -EnableProvisioning $EnableProvisioning `
            -MaximumCount $MaximumCount `
            -MinimumCount $MinimumCount `
            -NamingPattern $NamingPattern `
            -NumUnassignedMachinesKeptPoweredOn $NumUnassignedMachinesKeptPoweredOn `
            -PoolDisplayName $PoolDisplayName `
            -ProvisioningTime $ProvTime `
            -ReclaimVmDiskSpace $ReclaimVmDiskSpace `
            -RedirectWindowsProfile $RedirectWindowsProfile `
            -SpareCount $SpareCount `
            -StopProvisioningOnError $true `
            -StorageOvercommit $StorageOvercommit `
            -UseNativeSnapshots $UseNativeSnapshots `
            -UseSeparateDatastoresReplicaAndOSDisks $UseSeparateDatastoresReplicaAndOSDisks `
            -UseVSAN $UseVSAN `
            -Vcenter $Vcenter `
            -enableHTMLAccess $enableHTMLAccess `
            -defaultDisplayProtocol $defaultDisplayProtocol `
            -AutomaticLogoffMinutes $AutomaticLogoffMinutes `
            -allowUsersToChooseProtocol $allowUsersToChooseProtocol `
            -AutomaticLogoffPolicy $AutomaticLogoffPolicy `
            -PostSynchronizationScriptParameters $postsyncpara `
            -PostSynchronizationScriptName $postsyncscript `
