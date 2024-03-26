<#Script Info:
Title of PowerShell script: Disable provisioning & output to separate text file
Base PowerShell script credit to PROJECTURI https://github.com/unifiedfx/Send-XCommand AUTHOR Stephen Welsh @stephenwelsh at UnifiedFX http://www.unifiedfx.com/ COPYRIGHT 2016 UnifiedFX. All rights reserved.

Use PowerShell Commands on lines 15 and 16, issue PowerShell Commands using $devices = then press enter. 
Then use PowerShell command $devices."IP Address" and press enter for issuing mulitple commands to multiple endpoints.
Note: 
1. devices.csv file must reside in the same folder as this PowerShell Script 
2. that output text file will show up in same file directory as this PowerShell Script
3. update the device password in this powershell script (line 21)

$devices = import-csv -Path "devices.csv"
$devices."IP Address" | ?{$_} | %{.\provision_off.ps1 $_} | Tee-Object -file successandfailureoutput.txt

To run script against a single device, press green play button in PowerShell ISE window then enter IP address of device to run script against.
#>

Param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True,Position=1)]$IPAddress,
    [Parameter(Mandatory=$False,Position=2)][string]$UserName="admin",
    [Parameter(Mandatory=$False,Position=3)][string]$Password='password')

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
    $url = "https://"+ $IPAddress +"/putxml";
    Write-Host "Trying $IPAddress"
    $body = '<XmlDoc internal="True"><Configuration><Provisioning><Mode>OFf</Mode></Provisioning></Configuration></XmlDoc>'
    try {$resp = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -ContentType "text/xml" -Body $body; Write-Output "Success Setting Provisioning Mode Off for endpoint $IPAddress $_"} catch{Write-Output "Failed Setting Provisioning Mode Off for endpoint $IPAddress $_"}   
    Write-Host "XML Commands Script Completed"
}
