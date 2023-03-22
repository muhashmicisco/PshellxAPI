# PshellxAPI
Powershell for using xAPI with Cisco Endpoints

To run script against a single device, press green play button in PowerShell ISE window then enter IP address of device to run script against.
For issuing commands to multiple endpoints, update DeviceList.csv and copy and paste the following into the PowerShell CLI:

$devices = import-csv -Path "DeviceList.csv"
$devices."IP Address" | ?{$_} | %{.\PeripheralList.ps1 $_} | Tee-Object -file Listoutput.txt

Limitation of Liability: 
You are fully responsible for your use of this script AND I am not liable for damages or losses arising from its use.
