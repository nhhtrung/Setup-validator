#!/bin/bash
VALIDATOR=""
DELEGATOR=""
NODE_HOME=""
PASSWORD=""
WALLET_NAME=""
CHAIN=""

while true
do
    current_date=$(date) # get current date
    echo $current_date
    echo $PASSWORD | kid tx distribution withdraw-rewards $VALIDATOR --chain-id=$CHAIN --gas-prices 0.025utki --from=$WALLET_NAME --home $NODE_HOME --yes

    sleep 120s

    balance=$(kid query bank balances $DELEGATOR -o json| jq ".balances[].amount | tonumber")
    stake_to_delegate="$(($balance - 5000000))" # leaving 5000000 on the balance

    echo $PASSWORD | kid tx staking delegate $VALIDATOR ${stake_to_delegate}utki --chain-id=$CHAIN --fees 0.008tki --from=$WALLET_NAME --home $NODE_HOME --yes
    sleep 3h 
done
