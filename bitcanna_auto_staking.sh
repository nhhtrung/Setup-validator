#!/bin/bash
VALOPER=
WALLET=
CHAIN_ID=$(curl -s http://localhost:26657/status | jq -r '.result.node_info.network')
FEE=5000
echo "Wallet password:"
read -s password

while true;
do
  #Tx to withdraw the rewards:
  echo "Tx to retrieve your rewards:"
  echo -e "${password}" | bcnad tx distribution withdraw-rewards ${VALOPER} --commission --from ${WALLET} --chain-id ${CHAIN_ID} --fees ${FEE}ubcna -y
  sleep 120

  #Check the wallet now:
  AMOUNT=$(bcnad query bank balances wallet --chain-id ${CHAIN_ID} --output=json | jq -r '.balances[].amount')
  echo "Amount:"
  echo $AMOUNT

  #We do not want to fully empty the wallet :) :
  DEL=$(($AMOUNT-1000000))

  #Final step for delegation:

  echo -e "${password}" | bcnad tx staking delegate ${VALOPER} ${DEL}ubcna --from ${WALLET}  --chain-id ${CHAIN_ID} --fees ${FEE}ubcna -y

  #We wait now for a bit (1hour=>60*60=3600):
  sleep 3600
done
