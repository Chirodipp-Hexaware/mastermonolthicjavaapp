#!/bin/ksh
#
# Description: Job for checking intraday coroporate actions alerts
#

if [ -d "/usr/appl/ecc/system" ]
then
BATCH_ENV=system
echo $BATCH_ENV
fi
if [ -d "/usr/appl/ecc/uat" ]
then
BATCH_ENV=uat
echo $BATCH_ENV
fi
if [ -d "/usr/appl/ecc/prod" ]
then
BATCH_ENV=prod
echo $BATCH_ENV
fi

export BATCH_ENV

. /usr/appl/ecc/${BATCH_ENV}/release/CorporateActionJob.sh
