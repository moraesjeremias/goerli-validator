# Ethereum Goerli Validator
- This repo abstracts the heavy lift and shift work for setting up and run a Goerli Validator Node

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


## Setup Staking Launchpad Goerli
Once you've installed the release, let it sync and funded your wallet address you may submit your node to the [Staking Launchpad (Goerli Testnet)](https://goerli.launchpad.ethereum.org/en/)

1. Visit [Staking Launchpad (Goerli Testnet)](https://goerli.launchpad.ethereum.org/en/)
2. Click on Become a Validator Button
3. Read carefully the instructions and accept them. Check also the [validator checklist](https://goerli.launchpad.ethereum.org/en/checklist)
4. Choose geth as execution client and hit continue
5. Choose Nimbus as consensus client and hit continue
6. Select number of validators (1), paste your Metamask wallet address on Withdrawal address field and hit continue
7. Run `kubectl exec -ti deployment/goerli-validator -c nimbus -- /bin/sh`. Inside the `nimbus` container copy the deposit data values in `/nimbus-data/staking-deposit-cli/validator_keys/deposit_data.json` save it to a local `/tmp/nimbus/deposit_data.json` and upload it to [Staking Launchpad deposit data](https://goerli.launchpad.ethereum.org/en/upload-deposit-data) and hit continue.
8. Connect your wallet with funded address accept the terms and make a transaction to transform the goerli node into actual a validator.
9. Verify the submitted tfx on [Goerli etherscan](https://goerli.etherscan.io/tx/0x4b39784fe049aec0571c37862f7f214137b00a2c88f85ed9c59dd38d466f623c)
10. Validate your Goerli node validator request status on [Goerli Beacon chain](https://goerli.beaconcha.in/validator/0x8e46b6de48aac0fac4000a57b7faad4bb0505be6501683590bbc2c45730281f844dceb61996065f01cd50e681c21a18e#charts)

## WIP
- Automatic ledger snapshot download/recovery to speed up validation node bootstrap down to minutes/hour.
- Make prometheus metrics available to both execution and consesus layer