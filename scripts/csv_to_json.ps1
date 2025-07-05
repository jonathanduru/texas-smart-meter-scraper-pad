# CSV to JSON Transformation Script
# Converts Smart Meter Texas CSV exports to structured JSON

$folderPath = 'C:\Projects\Texas Smart Meter Reports'

# Get the most recent CSV file
$latestFile = Get-ChildItem -Path $folderPath -Filter '*.csv' | 
    Sort-Object LastWriteTime -Descending | 
    Select-Object -First 1

if ($latestFile) {
    # Import CSV data
    $csvData = Import-Csv -Path $latestFile.FullName
    
    # Transform to simplified structure
    $simplifiedData = $csvData | ForEach-Object {
        [PSCustomObject]@{
            Date = $_.USAGE_DATE
            DailyUsageKWH = $_.USAGE_KWH
            StartReading = $_.START_READING
            EndReading = $_.END_READING
        }
    }
    
    # Convert to JSON
    $jsonOutput = $simplifiedData | ConvertTo-Json -Depth 10
    
    # Output JSON
    Write-Output $jsonOutput
    
    # Optionally save to file
    # $jsonPath = $latestFile.FullName -replace '\.csv$', '.json'
    # $jsonOutput | Out-File -FilePath $jsonPath -Encoding UTF8
} else {
    Write-Error 'No CSV files found in the specified directory'
}