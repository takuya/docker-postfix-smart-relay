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

## when 'Relay access denied' occurred.
Default allowed network is `127.0.0.0/8, 172.16.0.0/12,192.168.0.0/16`

Add or change `ENV[POSTFIX_RELAY_MYNET]` as follows.
```shell
POSTFIX_RELAY_MYNET='127.0.0.0/8 192.168.2.0/24'
```

## docker compose 
```shell
vim docker-compose.yaml
docker compose up 
```
docker-compose.yaml 
```yaml
version: "3.7"
services:
  smart_relay:
    image: ghcr.io/takuya/docker-postfix-smart-relay:latest
    container_name: postfix_relay
    hostname: postfix_relay
    environment:
      TZ: 'Asia/Tokyo'
      POSTFIX_RELAY_MYNET: '127.0.0.0/8 192.168.100.0/24'
      POSTFIX_RELAY_HOST: '[smtp.example.tld]:587'
      POSTFIX_RELAY_USER: 'admin@from.tld'
      POSTFIX_RELAY_PASS: 'password'
      DOCKER_NETWORK: host
      LOG_LEVEL: "3"
      DEBUG: "true"
    network_mode: host
```


