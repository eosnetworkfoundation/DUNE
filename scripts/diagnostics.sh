#!/usr/bin/env bash

# intended to be run from inside docker container
docker --help &>/dev/null
if [[ $? -eq 0 ]]; then
  echo "Intended to be run from inside docker container, ssh into container first"
  exit 127
fi

VERSION_TITLE="Cleos Version Full"
VERSION_CMD=(cleos version full)
LOCAL_WALLET_TITLE="Create Local Wallet"
LOCAL_WALLET_CMD=(cleos wallet create --name diagnostics${$} --file /home/www-data/diagnostics${$}.wallet.pw )
SERVER_INFO_TITLE="Get Info from 127.0.0.1:8888"
SERVER_INFO_CMD=(cleos --url http://127.0.0.1:8888 get info)

cd /home/www-data

echo   "*********** PRINTING CONTEXT"
cat /home/www-data/.dune.ctx
echo

echo   "*********** Running ${VERSION_TITLE} "
"${VERSION_CMD[@]}"
if [[ $? -eq 0 ]]; then
  echo "       PASSED **********************" && echo
else
  echo "       FAILED exit code ${?} *******" && echo
fi

echo   "*********** Running ${LOCAL_WALLET_TITLE} "
"${LOCAL_WALLET_CMD[@]}"
if [[ $? -eq 0 ]]; then
  echo "       PASSED **********************" && echo
else
  echo "       FAILED exit code ${?} *******" && echo
fi

echo   "*********** Running ${SERVER_INFO_TITLE} "
"${SERVER_INFO_CMD[@]}"
if [[ $? -eq 0 ]]; then
  echo "       PASSED **********************" && echo
else
  echo "       FAILED exit code ${?} *******" && echo
fi
