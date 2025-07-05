$folderPath = "C:\Projects\Texas Smart Meter Reports"
$latestFile = Get-ChildItem -Path $folderPath -Filter "*.csv" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($latestFile) {
    $csvData = Import-Csv -Path $latestFile.FullName
    
    # Create simplified objects with just date and usage
    $simplifiedData = $csvData | ForEach-Object {
        [PSCustomObject]@{
            Date = $_.USAGE_DATE
            DailyUsageKWH = $_.USAGE_KWH
            StartReading = $_.START_READING
            EndReading = $_.END_READING
        }
    }
    
    $jsonOutput = $simplifiedData | ConvertTo-Json -Depth 10
    Write-Output $jsonOutput
} else {
    Write-Output "ERROR: No CSV files found"
}