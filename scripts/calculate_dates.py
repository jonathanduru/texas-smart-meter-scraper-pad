#---------------------------------------
# Python Script for StartDate Variable
#---------------------------------------

from datetime import datetime, timedelta

# yesterday in UTC
yesterday = datetime.utcnow().date() - timedelta(days=1)
# 30 days before yesterday
start = (yesterday - timedelta(days=30)).strftime("%m/%d/%Y")
print(start)

#---------------------------------------
# Python Script for EndDate Variable
#---------------------------------------

from datetime import datetime, timedelta

# yesterday in UTC
yesterday = datetime.utcnow().date() - timedelta(days=1)
print(yesterday.strftime("%m/%d/%Y"))