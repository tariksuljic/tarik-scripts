#Test the IPAddress with try catch block
try {
    $myAdapter = Read-Host -Prompt "Enter the name of the Network Adapter "
    [ipaddress]$ipAddress = Read-Host -Prompt "Enter an IPAddress "
    [Int]$subnetMask = Read-Host -Prompt "Enter the Subnet Mask (CIDR) "
    [ipAddress]$defaultGateway = Read-Host -Prompt "Enter the Default Gateway "
    [ipaddress]$dns = Read-Host -Prompt "Enter the DNS IP Address "
    [ipAddress]$alternateDNS = Read-Host -Prompt "Enter the alternate DNS IpAddress "

}
catch {
    Write-Host $PSItem.Exception.Message
}

$isOccupied = Test-Connection -Count 1 -Quiet $ipAddress

if ($isOccupied) {
    Write-Host "The Ip address $ipAddress is occupied"
    exit
}

try {
    Remove-NetIPAddress -InterfaceAlias $myAdapter
    Remove-NetRoute -InterfaceAlias $myAdapter

    New-NetIPAddress -InterfaceAlias $myAdapter -IPAddress $ipAddress -PrefixLength $subnetMask -DefaultGateway $defaultGateway
    Set-DnsClientServerAddress -InterfaceAlias $myAdapter -ServerAddresses $dns, $alternateDNS
}
catch {
    Write-Host "Error"
}

Write-Host "You have successfully configured the Network Adapter"