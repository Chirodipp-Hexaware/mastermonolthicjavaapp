#!/bin/ksh
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
JOBS_DIR=/usr/appl/ecc/${BATCH_ENV}

#JAVA_HOME=/usr/jdk/jdk1.6.0_20
JAVA_HOME=${JOBS_DIR}
export JAVA_HOME

MQ_JAVA_LIB=/opt/mqm/java/lib
MQ_CLASSPATH=${MQ_JAVA_LIB}/sol-common-10.3.0.jar::${MQ_JAVA_LIB}/sol-jcsmp-10.3.0.jar:${MQ_JAVA_LIB}/sol-jms-10.3.0-javadoc.jar:${MQ_JAVA_LIB}/sol-jms-10.3.0.jar:${MQ_JAVA_LIB}/geronimo-jms_1.1_spec-1.1.1.jar
#MQ_CLASSPATH=${MQ_JAVA_LIB}/com.ibm.mq.jar:${MQ_JAVA_LIB}/com.ibm.mqjms.jar:${MQ_JAVA_LIB}/dhbcore.jar:${MQ_JAVA_LIB}/fscontext.jar:${MQ_JAVA_LIB}/MQAUSXJ.jar
CP=`ls $JOBS_DIR/lib/*.jar | awk '{classpath=classpath$1":"} END {print substr(classpath,0,length(classpath)-1)}'`

CP=$JOBS_DIR/release/eceJavaJob.jar:$JOBS_DIR/release:$JOBS_DIR/release/config:$JOBS_DIR/release/config/ece.properties:$JOBS_DIR/release/config/jobApplicationContext.xml:$CP${MQ_CLASSPATH}

cd $JOBS_DIR

echo "JOBS DIR: "
echo $JOBS_DIR
echo
echo "CLASSPATH: "
echo $CP
echo

$JAVA_HOME/bin/java -version

$JAVA_HOME/bin/java -Xms512m -Xmx2048m -classpath $CP com/ntrs/ece/batch/common/LoadBatchAccounts CACTN

