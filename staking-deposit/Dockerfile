FROM alpine:3.18.2
WORKDIR /staking
RUN apk update && apk add curl && \
curl -fsSL -o staking_deposit_cli.tar.gz https://github.com/ethereum/staking-deposit-cli/releases/download/v2.5.0/staking_deposit-cli-d7b5304-linux-amd64.tar.gz && \
tar -xvzf staking_deposit_cli.tar.gz && \ 
rm -f staking_deposit_cli.tar.gz
ENTRYPOINT [ "/bin/sh" ]