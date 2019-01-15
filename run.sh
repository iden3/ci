rm -rf /tmp/treedb

echo 🐮 Starting the server -------------------------------------
./go-iden3/relay --config config.yaml start & 
RELAYPID=$!

echo 🐮 Wait 5 seconds to initialize server, pid $RELAYPID ------
sleep 5

echo 🐮 Running the tests now -----------------------------------
cd iden3js
npm run test:all
TESTRESULT=$?

if [ $TESTRESULT -eq 0 ]; then
    echo Tests OK
else
    echo Tests FAIL
fi

echo 🐮 Killing the server -------------------------------------
kill -9 $RELAYPID

echo 🐮 Server killed ------------------------------------------

exit $TESTRESULT