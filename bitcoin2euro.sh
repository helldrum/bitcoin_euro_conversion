#!/bin/bash

  set -x
  balance=""
  currency=EUR
  bitcoin_addr="" # put here your bitcoin addr
  while [[ -z "$balance" ]];do # sometime api reply error , so loop until you get a true response
    sleep 1
    balance=$(curl  "https://blockexplorer.com/api/addr/$bitcoin_addr" 2&> /dev/null |python -c 'import sys, json; print json.load(sys.stdin)["balance"]' 2&> /dev/null)
  done
  euro_rate=$(curl "https://api.coinbase.com/v2/exchange-rates?currency=BTC" 2&> /dev/null | python -c 'import sys, json; print json.load(sys.stdin)['data']['rates']['$currency']")
  echo "balance is $balance BTC,evaluate to $(echo "$balance * $euro_rate" | bc -l |cut -f1 -d".") euro on coinbase"
}


