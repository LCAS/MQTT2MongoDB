#!/bin/bash


if [ $# == 0 ]
  then
    echo "No arguments supplied, you need to pass one arg 'full' or 'only-mqtt2mongodb'"
    exit 1
else
  if [ "$1" == "full" ]
  then
    DOCKER_COMPOSE_FILE="docker-compose.full.yml"
  else
    if [ "$1" == "only-mqtt2mongodb" ]
    then
      DOCKER_COMPOSE_FILE="docker-compose.yml"
    fi
  fi
fi

MQTT2MONGODB_GITRAW=https://raw.githubusercontent.com/juniorsaldanha/MQTT2MongoDB/master

echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"
echo "|                            Now we will Download some file to your computer                                |"
echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"

curl -sS $MQTT2MONGODB_GITRAW/.env_mqtt2mongodb -o .env_mqtt2mongodb
source .env_mqtt2mongodb

mkdir $MQTT2MONGODB_PATH
mv .env_mqtt2mongodb $MQTT2MONGODB_PATH/.env
cd $MQTT2MONGODB_PATH

curl -sS $MQTT2MONGODB_GITRAW/appsettings.json -o ./appsettings.json
curl -sS $MQTT2MONGODB_GITRAW/$DOCKER_COMPOSE_FILE -o ./docker-compose.yml


echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"
echo "|  Now we will download the image from Docker Hub, this will take a while, depends on you internet speed   |"
echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"

sudo docker-compose pull --quiet #pulling just to be sure that you have lastest version
sudo docker-compose up -d
sudo docker-compose ps

clear
echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"
echo "|                 Download of the image is completed, and the container is running                         |"
echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"
echo ""
echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"
echo "|Change the 'appsettings.json' file to your own configuration, and restart the container with command below|"
echo "| -->                                     docker-compose restart                                        <--|"
echo "|                                                                                                          |"
echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"
echo "|           Check out my GitHub on https://github.com/juniorsaldanha/MQTT2MongoDB @UmSaldanha              |"
echo "|_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻_⎻|"
