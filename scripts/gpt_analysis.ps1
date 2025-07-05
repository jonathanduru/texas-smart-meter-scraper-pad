# Get API Key from environment
$apiKey = [System.Environment]::GetEnvironmentVariable("OPENAI_API_KEY", "User")

# Get the most recent CSV file
$folderPath = "C:\Projects\Texas Smart Meter Reports"
$latestFile = Get-ChildItem -Path $folderPath -Filter "*.csv" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($latestFile) {
    # Read and process CSV
    $csvData = Import-Csv -Path $latestFile.FullName
    
    # Create simplified data
    $simplifiedData = $csvData | ForEach-Object {
        [PSCustomObject]@{
            Date = $_.USAGE_DATE
            DailyUsageKWH = $_.USAGE_KWH
        }
    }
    
    # Convert to JSON string
    $dataJson = $simplifiedData | ConvertTo-Json -Depth 10
    
    # Create the complete request
    $headers = @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $apiKey"
    }
    
    $body = @{
        model = "gpt-3.5-turbo"
        messages = @(
            @{
                role = "system"
                content = "You are an energy consumption analyst. Analyze the electricity usage data provided and give insights on: 1) Total usage and daily average, 2) Peak usage days and potential reasons, 3) Usage patterns (weekday vs weekend), 4) Cost-saving recommendations, 5) Any unusual consumption patterns."
            },
            @{
                role = "user"
                content = "Here is my 30-day electricity usage data: $dataJson"
            }
        )
        temperature = 0.7
        max_tokens = 1500
    } | ConvertTo-Json -Depth 10
    
    # Make the API call
    try {
        $response = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" -Headers $headers -Method Post -Body $body
        
        # Extract just the analysis text
        $analysis = $response.choices[0].message.content
        Write-Output $analysis
    }
    catch {
        Write-Output "ERROR: API call failed - $_"
    }
} else {
    Write-Output "ERROR: No CSV files found"
}