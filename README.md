# Texas Smart Meter Scraper

An automated Power Automate Desktop solution that collects and analyzes monthly electricity usage data from Smart Meter Texas. The project demonstrates RPA capabilities combined with data processing and AI-powered analytics.

---

> **Flow Architecture**  
> See the Power Automate Desktop flow structure with three modular subflows working together:

**![PAD Flow Overview](images/pad-flow-overview.gif)**
*Main orchestration flow showing ScrapeUsage, ProcessFile, and GPT_Injection subflows*

---

## Overview

This automation runs monthly to:
- Authenticate and navigate the Smart Meter Texas web portal
- Download the last 30 days of electricity usage data
- Process the raw CSV data into structured JSON format
- Generate insights using OpenAI's GPT model

## Architecture

The solution consists of three modular subflows:

**![PAD Main Flow Structure](images/pad-main-flow.png)**
<!-- PLACEHOLDER: Screenshot of PAD showing the main flow with three subflows listed
Show the flow designer with ScrapeUsage, ProcessFile, and GPT_Injection visible -->

### ScrapeUsage
Handles web automation using Chrome to:
- Authenticate with stored credentials
- Navigate to the reporting section
- Configure date ranges dynamically using Python
- Export usage data as CSV

**![Web Scraping in Action](images/web-scraping-demo.gif)**
<!-- PLACEHOLDER: 15-20 second GIF showing:
- Browser launching and navigating to Smart Meter Texas
- Automated login (with credentials blurred)
- Date selection using Python calculations
- Report generation and download
-->

*The flow uses Python scripts to calculate dynamic date ranges and Chrome automation for reliable data extraction*

### ProcessFile
Manages data pipeline operations:
- Monitors download completion
- Relocates files to project directory
- Transforms CSV to JSON using PowerShell
- Structures data for analysis (Date, Usage KWH, Meter Readings)

**![Data Processing Automation](images/data-processing-demo.gif)**
<!-- PLACEHOLDER: 10-15 second GIF showing:
- File appearing in downloads folder
- File being moved to project directory
- PowerShell window executing transformation
- JSON output being generated
-->

*PowerShell scripts handle the CSV to JSON transformation, structuring the data for AI analysis*

### GPT_Injection
Integrates with OpenAI API to:
- Retrieve API credentials from environment variables
- Construct analysis prompts with usage data
- Generate comprehensive consumption insights
- Display analysis results

**![GPT Analysis Output](images/gpt-analysis-output.png)**
<!-- PLACEHOLDER: Screenshot of the PAD message box showing GPT analysis results
Should show usage summary, patterns, and recommendations -->

## Technical Stack

- **VMware Workstation** - Isolated virtual environment for secure automation
- **Power Automate Desktop** - Orchestration and UI automation
- **Python** - Dynamic date calculations
- **PowerShell** - Data transformation and API integration
- **OpenAI API** - Consumption pattern analysis
- **Chrome WebDriver** - Browser automation

## Key Features

- **Isolated Execution**: Runs in VMware virtual machine for security and portability
- **Dynamic Date Handling**: Automatically calculates rolling 30-day windows
- **Error Resilience**: Built-in waits and file existence checks
- **Secure Credential Management**: Environment variable storage for API keys
- **Modular Design**: Reusable subflows for maintainability
- **Data Pipeline**: CSV to JSON transformation with field mapping

## Data Analysis Capabilities

The system analyzes:
- Total usage and daily averages
- Peak consumption identification
- Weekday vs weekend patterns
- Cost optimization opportunities
- Anomaly detection in usage patterns

## Implementation Highlights

- Leverages browser automation for sites without APIs
- Combines multiple scripting languages for optimal task handling
- Implements proper file management and data transformation
- Integrates modern AI capabilities for actionable insights

## Project Structure

```
Texas-Smart-Meter-Scraper/
├── README.md                    # Project overview and quick start
├── docs/
│   ├── ARCHITECTURE.md         # Technical design and flow details
│   ├── SETUP.md               # Environment setup and prerequisites
│   └── ANALYSIS_EXAMPLES.md   # Sample GPT analysis outputs
├── flows/
│   ├── Main.txt               # Main Power Automate Desktop flow
│   ├── ScrapeUsage.txt        # Web scraping subflow
│   ├── ProcessFile.txt        # Data processing subflow
│   └── GPT_Injection.txt      # AI analysis subflow
├── scripts/
│   ├── calculate_dates.py     # Date range calculation logic
│   ├── csv_to_json.ps1       # CSV transformation script
│   └── gpt_analysis.ps1      # OpenAI API integration
├── samples/
│   ├── sample_input.csv      # Example meter data format
│   ├── sample_output.json    # Transformed data structure
│   └── sample_analysis.txt   # GPT-generated insights
├── .gitignore
└── LICENSE
```

### Directory Guide

- **`docs/`** - Detailed technical documentation and setup guides
- **`flows/`** - Power Automate Desktop flow exports for reference
- **`scripts/`** - Standalone versions of embedded automation scripts
- **`samples/`** - Example data showing input/output formats without exposing actual usage data