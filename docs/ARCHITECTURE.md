# Technical Architecture

## System Design

The Texas Smart Meter Scraper uses a three-tier architecture:

1. **Data Collection Layer** - Web automation for meter data retrieval
2. **Processing Layer** - Data transformation and formatting
3. **Analysis Layer** - AI-powered consumption insights

**![System Architecture Diagram](../images/architecture-diagram.png)**
<!-- PLACEHOLDER: Create a diagram showing:
- Three layers (Collection, Processing, Analysis)
- Data flow between layers
- External systems (Smart Meter Texas, OpenAI API)
- Use draw.io or similar tool, export as PNG -->

## Flow Architecture

### Main Flow Orchestration

**![Flow Orchestration Detail](../images/flow-orchestration.png)**
<!-- PLACEHOLDER: Screenshot of PAD showing:
- Main flow with all actions expanded
- Variable assignments between subflows
- Error handling blocks highlighted -->

The main flow coordinates three subflows in sequence:
1. **ScrapeUsage** - Returns download status
2. **ProcessFile** - Returns JSON data path
3. **GPT_Injection** - Returns analysis text

### Error Handling Strategy

**![Error Handling Flow](../images/error-handling.png)**
<!-- PLACEHOLDER: Screenshot showing PAD error handling:
- Try-catch blocks in the flow
- Retry logic for web scraping
- Fallback paths -->

## Data Flow

```
Smart Meter Texas Portal
        ↓
    Chrome Automation
        ↓
    CSV Download
        ↓
    File Processing
        ↓
    JSON Transformation
        ↓
    OpenAI Analysis
        ↓
    Insights Display
```

**![Data Pipeline Visualization](../images/data-pipeline.png)**
<!-- PLACEHOLDER: Visual diagram showing:
- Sample data at each stage
- Data format transformations
- File locations and API calls -->

## Security Considerations

- **Virtual Machine Isolation**: Entire automation runs in VMware VM
  - Prevents direct access to host system
  - Easy snapshot/rollback capabilities
  - Network isolation options available
- **Credential Management**: 
  - Environment variables for API keys
  - No hardcoded sensitive data
  - VM-specific credential storage
- **Data Protection**:
  - Downloaded files stay within VM
  - Analysis results contained in isolated environment

**![VMware Environment Setup](../images/vmware-environment.png)**
<!-- PLACEHOLDER: Screenshot showing:
- VMware Workstation with the VM running
- VM settings showing isolation features
- Windows desktop inside VM with PAD open -->

## Performance Optimizations

- Parallel processing where possible
- Efficient file handling with minimal disk I/O
- Cached browser sessions for faster automation
- Optimized PowerShell scripts for large datasets

## Detailed Flow Implementation

### ScrapeUsage Subflow Details

**![ScrapeUsage Flow Actions](../images/scrapeusage-details.png)**
<!-- PLACEHOLDER: Screenshot of PAD showing the ScrapeUsage subflow with all actions expanded:
- Browser launch action
- Login sequence
- Date calculation Python scripts
- Report submission steps -->

### ProcessFile Subflow Details

**![ProcessFile Flow Actions](../images/processfile-details.png)**
<!-- PLACEHOLDER: Screenshot of PAD showing the ProcessFile subflow:
- File monitoring actions
- Move file action
- PowerShell script action
- Variable assignments -->

### GPT_Injection Subflow Details

**![GPT_Injection Flow Actions](../images/gpt-injection-details.png)**
<!-- PLACEHOLDER: Screenshot of PAD showing the GPT_Injection subflow:
- Environment variable retrieval
- PowerShell API call action
- Display message action with result -->