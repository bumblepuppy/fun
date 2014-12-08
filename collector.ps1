﻿
$archiveDir = get-item C:\Users\James\projects\HearthStoneDebugLog\archive

$logFile = get-item "E:\Program Files (x86)\Hearthstone\Hearthstone_Data\output_log.txt"

$archivedFiles = Get-ChildItem $archiveDir | Sort-Object -Property CreationTime -Descending

if (($archivedFiles.Count -gt 0) -and ($archivedFiles[0].CreationTime -gt $logFile.CreationTime ) -and ($archivedFiles[0].Length -gt 0)) {
    # the archive is more recent than the source, so bail
    exit
}

$hearthstoneProcessCount=Get-Process Hearthstone -ErrorAction SilentlyContinue | Measure-Object

if ( $hearthstoneProcessCount.Count -lt 1 ) {
    # no hearthstone process running, so copy away!
    $dateTimeString=Get-Date -Format yyyyMMddHHmm
    Push-Location $archiveDir
    Copy-Item $logFile "$dateTimeString.txt"
    Pop-Location
}   