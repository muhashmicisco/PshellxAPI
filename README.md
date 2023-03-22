<b>Limitation of Liability: <br>
You are fully responsible for your use of this script AND I am not liable for damages or losses arising from its use.<br>
<br></b>
PshellxAPI<br>
Powershell for using xAPI with Cisco Endpoints<br>
<br>
Instructions:<br>
Download all files in the repository and update credentials in the .ps1 file. To run script against a single device, press green play button in PowerShell ISE window then enter IP address of device to run script against.<br><br>
For issuing commands to multiple endpoints, update DeviceList.csv and copy and paste the following into the PowerShell CLI:<br>
<p><b>
$devices = import-csv -Path "DeviceList.csv"<br>
$devices."IP Address" | ?{$_} | %{.\PeripheralList.ps1 $_} | Tee-Object -file Listoutput.txt<br></p>
</b>
A file named <b>Listoutput.txt<b> will be created to log the screen output, so you can view errors, etc.<br>
<br>
Example of screen output:<br>

<br>
Example of output.csv:<br>

<br>
Troubleshooting:<br>
Remember to enable execution of scripts if you get the following error:<br>

<br>
To enable scripts run Powershell as an Administrator and execute the following:<br>
<b>Set-ExecutionPolicy RemoteSigned</b><br>
<br>
Cisco DX, Hub, Desk, Board devices unless connected to active peripherals will output null for the xAPI, exclude them from the device list if possible. The following error is expected to occur otherwise:<br>


 
