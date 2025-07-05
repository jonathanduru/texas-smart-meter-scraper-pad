#!/usr/bin/env python3
"""
Date calculation scripts for Texas Smart Meter Scraper
Used within Power Automate Desktop flows
"""

from datetime import datetime, timedelta

def get_start_date():
    """Calculate start date (30 days before yesterday)"""
    yesterday = datetime.utcnow().date() - timedelta(days=1)
    start = (yesterday - timedelta(days=30)).strftime("%m/%d/%Y")
    return start

def get_end_date():
    """Calculate end date (yesterday)"""
    yesterday = datetime.utcnow().date() - timedelta(days=1)
    return yesterday.strftime("%m/%d/%Y")

if __name__ == "__main__":
    # Example usage
    print(f"Start Date: {get_start_date()}")
    print(f"End Date: {get_end_date()}")