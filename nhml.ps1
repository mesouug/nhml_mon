# NHML monitoring script
# Installation:
# 1. Run powershell as Administrator and execute:
#   > Set-ExecutionPolicy remotesigned
# 2. Create link pointing to `nhml.ps1` script (example):
#   %SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -File c:\nhml.ps1
# 3. Copy link to Windows autostart directory.

$minerbin = "NiceHashMinerLegacy.exe"
$minerabs = "C:\nicehash\$minerbin"
$delay = 90
$bins = "xmr-stak-cpu.exe", "xmrig.exe", "ccminer.exe", "ethminer.exe", "excavator.exe", "nheqminer.exe", "sgminer.exe", "NsGpuCNMiner.exe", "EthDcrMiner64.exe", "ZecMiner64.exe", "miner.exe", "Optiminer.exe", "prospector.exe"

echo "$(date) NHML monitoring script started."

while ($true) {
  $notfound = $true

  foreach ($bin in $bins) {
    if (tasklist | Select-String $bin) {
      $notfound = $false
      exit
    }
  }

  if ($notfound) {
    echo "$(date) No miner started. Restarting NHML!"
    taskkill /im $minerbin /t /f
    Start-Sleep -s 1
    Start $minerabs
  }
  Start-Sleep -s $delay
}
