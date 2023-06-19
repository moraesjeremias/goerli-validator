# Ethereum Goerli Validator
- This repo abstracts the heavy lift and shift work for setting up and run and Goerli Validator

## Pre-requisites
- Access to Kubernetes cluster v1.23+
- Enable ports 5052, 8545, 8546, 8551, 9000 and 30303 on your cloud firewall product. Make sure your kubernetes distribution uses the same firewall configured.

[AWS VPC Security Group](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest#security-group-with-custom-rules)

[GCP VPC Firewall Rules](https://cloud.google.com/firewall/docs/using-firewalls#terraform)

- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [helm3](https://helm.sh/docs/intro/install/)

## Techs used
### Blockchain Related
- Execution client: geth v1.25.0
- Consensus client: Nimbus v23.5.1

### Infra related
- helm charts
- Kubernetes

## Create a metamask wallet
1. Follow [this guide](https://support.metamask.io/hc/en-us/articles/360015489531-Getting-started-with-MetaMask) to create your metamask wallet if not holding one yet.
2. [Switch to Goerli Network](https://support.metamask.io/hc/en-us/articles/13946422437147-How-to-view-testnets-in-MetaMask).
3. Copy your wallet address and get 32 GoerliETH in any faucet available in [faucet link](https://faucetlink.to/goerli) (Beware that due to previous scams and unfair usage, those faucets have daily funding limits).

## Running your Goerli Validator Node

### Validate your Kubernetes context

`kubectl config get-context`

### Install the Helm release

`helm upgrade --install goerli-validator ./geth-validator-chart -f ./geth-validator-chart/values.yaml`

> Note: you must wait until your goerli node gets fully synced


## WIP
- Automatic ledger snapshot download/recovery to speed up validation node bootstrap down to minutes/hour.
- Make prometheus metrics available to both execution and consesus layer