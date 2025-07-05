# GPT Analysis Script
# Sends electricity usage data to OpenAI for analysis

# Retrieve API key from environment
$apiKey = [Environment]::GetEnvironmentVariable('OPENAI_API_KEY', 'User')

if (-not $apiKey) {
    Write-Error "OpenAI API key not found in environment variables"
    exit 1
}

$folderPath = 'C:\Projects\Texas Smart Meter Reports'

# Get the most recent CSV file
$latestFile = Get-ChildItem -Path $folderPath -Filter '*.csv' | 
    Sort-Object LastWriteTime -Descending | 
    Select-Object -First 1

if ($latestFile) {
    # Import and transform data
    $csvData = Import-Csv -Path $latestFile.FullName
    $simplifiedData = $csvData | ForEach-Object {
        [PSCustomObject]@{
            Date = $_.USAGE_DATE
            DailyUsageKWH = $_.USAGE_KWH
        }
    }
    
    $dataJson = $simplifiedData | ConvertTo-Json -Depth 10
    
    # Prepare API request
    $headers = @{
        'Content-Type' = 'application/json'
        'Authorization' = "Bearer $apiKey"
    }
    
    $systemPrompt = @"
You are an energy consumption analyst. Analyze the provided electricity usage data and provide:
1. Total usage and daily average
2. Peak usage days (top 3)
3. Weekday vs weekend consumption patterns
4. Potential cost-saving recommendations
5. Any unusual consumption patterns or anomalies
"@
    
    $userPrompt = "Here is my 30-day electricity usage data:\n$dataJson"
    
    $body = @{
        model = 'gpt-3.5-turbo'
        messages = @(
            @{ role = 'system'; content = $systemPrompt },
            @{ role = 'user'; content = $userPrompt }
        )
        temperature = 0.7
        max_tokens = 1500
    } | ConvertTo-Json -Depth 10
    
    try {
        # Make API request
        $response = Invoke-RestMethod -Uri 'https://api.openai.com/v1/chat/completions' `
            -Headers $headers -Method Post -Body $body
        
        # Extract and display analysis
        $analysis = $response.choices[0].message.content
        Write-Output $analysis
        
        # Optionally save analysis
        # $analysisPath = $latestFile.FullName -replace '\.csv$', '_analysis.txt'
        # $analysis | Out-File -FilePath $analysisPath -Encoding UTF8
    } catch {
        Write-Error "API request failed: $_"
    }
} else {
    Write-Error 'No CSV files found in the specified directory'
}