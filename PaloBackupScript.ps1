
## Download device state (requires superuser)
#curl "https:///api/?type=export&category=device-state&key=" -OutFile ("$dest\_DeviceState" + "$Date" +".tgz")

## Date & Time Stamp:
$Date = (Get-Date).ToString('MM_dd_yyyy')

## Device State Folder Locations

$destDevice = "\\<uncpathhere>\Palo Alto Automated Backups\DeviceState"
###Copy Past for more locations

## Running Config Folder locations:
$destRunning = "\\<uncpathhere>\Palo Alto Automated Backups\RunningConfig"
###Copy Past for more locations


## Download Device State Config

curl "https://<PALO-HPPTS-DNS-NAME>/api/?type=export&category=device-state&key=PALO-API-KEY" -OutFile ("$destDevice\DeviceStateConfiguration" + "$Date" +".xml")
Start-Sleep -Seconds 10

## Download running config:
curl "https://<PALO-HTTPS-DNS-NAME>/api/?type=export&category=configuration&key=PALO-API-KEY" -OutFile ("$destRunning\RunningConfiguration" + "$Date" +".xml")
Start-Sleep -Seconds 10

## Remove Device State backups older than 30 days:
Get-ChildItem –Path "\\<uncpathhere>\Palo Alto Automated Backups\DeviceState" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30))} | Remove-Item
Start-Sleep -Seconds 10

## Remove Running Config backups older than 30 days:

Get-ChildItem –Path "\\<uncpathhere>\Palo Alto Automated Backups\RunningConfig" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30))} | Remove-Item
Start-Sleep -Seconds 10
