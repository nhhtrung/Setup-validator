#!/bin/bash

WALLET_PASS=""
CHAIN=
HOME_DIR=""
WALLET_NAME=""


echo 'Listening:'
while true; do
current_date=$(date)
POWER=$(kid status 2>&1 | jq '.ValidatorInfo.VotingPower | tonumber')

echo $current_date  'WE HAVE POWER' $POWER

if [ $POWER = 0 ]; then # if power == 0 then we jailed
    current_date=$(date) #overriding datetime
    echo $current_date 'UNJAILING' 
    echo -e "$WALLET_PASS\n" | kid tx slashing unjail --chain-id=$CHAIN --from=$WALLET_NAME --gas=auto --yes --home $HOME_DIR

fi
sleep 15 # repeating every 15 sec
done

