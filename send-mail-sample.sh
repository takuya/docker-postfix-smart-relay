ADDR=$1
FROM=$2
HOST=localhost
if [ ! -z $3 ] ; then HOST=$3; fi

echo "To: ${ADDR}
From: ${FROM}
Subject: test mail / $(date +"%F %T")


this is a test$(echo $RANDOM).

---
at $(date +"%F %T" )

"  | curl -v  --url "smtp://${HOST}:25"  --mail-rcpt ${ADDR}  --mail-from ${FROM}  -T -


