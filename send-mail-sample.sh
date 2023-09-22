ADDR=$1
FROM=$2

echo "To: ${ADDR}
From: ${FROM}
Subject: test mail / $(date +"%F %T")


this is a test$(echo $RANDOM).

---
at $(date +"%F %T" )

"  | curl -v  --url 'smtp://localhost:25'  --mail-rcpt ${ADDR}  --mail-from ${FROM}  -T -


