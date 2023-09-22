# docker-postfix-smart-relay

Run postfix smart relay in docker

## Run (build manually )

```shell
git clone git@github.com:takuya/docker-postfix-smart-relay.git
IMAGE=takuya/docker-postfix
cp env.sample env
vim env
docker build -t $IMAGE .
docker run -d --env-file env --rm  -p 127.0.0.1:25:25 $IMAGE
## send test mail
./send-mail-sample takuya@recipient.tld admin@from.tld
```

## env sample
```shell
## environment
POSTFIX_RELAY_HOST=[smtp.example.com]:587 ## smart relay host 
POSTFIX_RELAY_USER=admin@you.tld ## smtp  user
POSTFIX_RELAY_PASS=passWord      ## smtp pass
```

