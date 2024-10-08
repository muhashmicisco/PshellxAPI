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
Two new files will be created when this script runs. A file named <b>Listoutput.txt<b> will be created to log the screen output, so you can view errors, etc.<br>
<br>
Example of screen output:<br>
<img src="https://user-images.githubusercontent.com/85717393/226981456-186a8de8-d36f-469b-8500-9de1d250b67a.png">
<br>
And the content from the xApi will be tabulated in output.csv, example below:<br>
<img src="https://user-images.githubusercontent.com/85717393/226969247-7d0ce7c8-e2e5-48e4-8740-6ddf9017f1c1.png">
<br><br>
Troubleshooting:<br>
Remember to enable execution of scripts if you get the following error:<br>
<img src="https://user-images.githubusercontent.com/85717393/226980273-f3e65ce0-8253-484a-9ecc-a6e18acfc2ac.png">
<br>
To enable scripts run Powershell as an Administrator and execute the following:<br>
<b>Set-ExecutionPolicy RemoteSigned</b><br>
<br>
Cisco DX, Hub, Desk, Board devices unless connected to active peripherals will output null for the xAPI, exclude them from the device list if possible. The following error is expected to occur otherwise:<br>
<img src="https://user-images.githubusercontent.com/85717393/226979775-f3ba9274-5153-4446-afee-7bcaea53a7bd.png">
