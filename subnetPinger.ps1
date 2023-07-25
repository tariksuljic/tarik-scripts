$ipAddress = (Get-NetIPAddress -AddressFamily IPv4).IPAddress[0]
# Get the ipAddress based on a specific InterfaceAlias
# $ipAddress=(Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "vEthernet (External)").IPAddress

for ($i = 1; $i -lt 255; $i++) {
    Test-Connection ($ipAddress -replace "\d{1,3}$", $i) -Count 1 -ErrorAction SilentlyContinue
}


