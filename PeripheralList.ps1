<#Script Info:
 
To run script against a single device, press green play button in PowerShell ISE window then enter IP address of device to run script against.
For issuing commands to multiple endpoints, update DeviceList.csv and copy and paste the following into the PowerShell CLI:

$devices = import-csv -Path "DeviceList.csv"
$devices."IP Address" | ?{$_} | %{.\PeripheralList.ps1 $_} | Tee-Object -file Listoutput.txt

#>

Param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True,Position=1)]$IPAddress,
    [Parameter(Mandatory=$False,Position=2)][string]$UserName="admin",
    [Parameter(Mandatory=$False,Position=3)][string]$Password='cisco')

Process{
    [Reflection.Assembly]::LoadWithPartialName("System.Xml.Linq") | Out-Null
    add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3, [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes(("{0}:{1}" -f $UserName,$Password)))
    $headers = @{"Authorization" = "Basic "+ $base64AuthInfo;}
    $url = "https://"+ $IPAddress +"/getxml?location=/Status/Peripherals"
    Write-Host "Trying $IPAddress"  
    try {$resp = Invoke-RestMethod -Uri $url -Method Get -Headers $headers; Write-Output "HardwareInfo for $IPAddress $_ is"$resp.Status.Peripherals.ConnectedDevice;$resp.Status.Peripherals.ConnectedDevice | export-csv output.csv -noType -Append; Add-Content -Path output.csv -Value $IPAddress -Encoding UTF8} catch {Write-Output "Failed for endpoint $IPAddress $_"}   
}
