# Setup Guide

## Prerequisites

### Host System
- VMware Workstation 16+ or VMware Player
- 8GB+ RAM (to allocate 4GB to VM)
- 50GB+ free disk space

### Virtual Machine Requirements
- Windows 10/11 VM
- 4GB RAM allocated
- 40GB disk space
- Network adapter configured (NAT or Bridged)

### Software Inside VM
- Power Automate Desktop (free version)
- Python 3.x
- PowerShell 5.1 or higher
- Chrome browser
- OpenAI API key

## Environment Setup

### 1. VMware Configuration
- Create new VM with Windows 10/11
- Allocate 4GB RAM minimum
- Enable virtualization features (VT-x/AMD-V)
- Install VMware Tools for better performance
- Configure shared folders if needed

### 2. Power Automate Desktop
- Install from Microsoft Store inside VM
- Sign in with Microsoft account
- Enable browser extensions for Chrome

### 3. Python Installation
```bash
# Verify Python installation
python --version
```

### 4. Environment Variables
Set the following environment variable:
```powershell
[Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'your-api-key', 'User')
```

### 5. Directory Structure
Create the following directory:
```
C:\Projects\Texas Smart Meter Reports
```

## Smart Meter Texas Account

[Document account setup requirements]

## Running the Automation

### VM Preparation
1. Take a VM snapshot before first run
2. Ensure VM has internet connectivity
3. Verify Chrome can access Smart Meter Texas

### Importing Flows
1. Open Power Automate Desktop in VM
2. Create new flow named "Texas Smart Meter Scraper"
3. Add subflows: ScrapeUsage, ProcessFile, GPT_Injection
4. Copy action sequences from documentation

### Execution
1. Run from within VM only
2. Monitor first run carefully
3. Check all paths and credentials
4. Snapshot VM after successful configuration