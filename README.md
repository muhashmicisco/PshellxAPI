PshellxAPI<br>
Powershell for using xAPI with Cisco Endpoints<br>
<br>
To run script against a single device, press green play button in PowerShell ISE window then enter IP address of device to run script against.<br>
For issuing commands to multiple endpoints, update DeviceList.csv and copy and paste the following into the PowerShell CLI:<br>
<p><b>
$devices = import-csv -Path "DeviceList.csv"<br>
$devices."IP Address" | ?{$_} | %{.\PeripheralList.ps1 $_} | Tee-Object -file Listoutput.txt<br></p>
</b>
Remember to enable execution of scripts if you get the following error:<br>
<b>.\PeripheralList.ps1 : File C:\PeripheralList.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see
about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.</b><br><br>

To enable scripts run Powershell as an Administrator and execute the following:<br>
<b>Set-ExecutionPolicy RemoteSigned</b><br>
<br>
Limitation of Liability: <br>
You are fully responsible for your use of this script AND I am not liable for damages or losses arising from its use."
