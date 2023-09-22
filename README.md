# docker-postfix-smart-relay

Run postfix smart relay in docker
## pull and run.

```shell
docker pull ghcr.io/takuya/docker-postfix-smart-relay:latest
docker run --env-file env -p 25:25 ghcr.io/takuya/docker-postfix-smart-relay
```
## Run (from ghcr.io)
pull image from GitHub's container registry. 
```shell
mkdir working; cd working
cat <<EOF > env
## environment
POSTFIX_RELAY_HOST=[smtp.example.com]:587
POSTFIX_RELAY_USER=admin@from.tld
POSTFIX_RELAY_PASS=passWord
EOF
## run 
docker pull ghcr.io/takuya/docker-postfix-smart-relay:latest
docker run -d --env-file env --rm  -p 127.0.0.1:25:25 ghcr.io/takuya/docker-postfix-smart-relay
## send sample
bash send-mail-sample.sh takuya@receipent.tld admin@from.tld
```

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
POSTFIX_RELAY_USER=admin@you.tld ## smtp user
POSTFIX_RELAY_PASS=passWord      ## smtp pass
```

