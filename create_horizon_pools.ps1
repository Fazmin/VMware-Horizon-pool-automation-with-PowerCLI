# Automate VMWare desktop Creation process
# Tested - vCenter 7.2
# for more indepth information please visit https://github.com/vmware/PowerCLI-Example-Scripts/tree/master/Modules/VMware.Hv.Helper.
# Custmized script written by: Fazmin Nizam
# This will create pools based on the Selected golden images make sure to add the required data prior executingt the script.

#Credentials
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