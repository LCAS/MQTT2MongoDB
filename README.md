# MQTT2MongoDB

A simple Python project that listen to one or more MQTT topics and save all the incoming messages on a MongoDB database, as some sort of logger.

# Sections
0. [MQTT2MongoDB](#mqtt2mongodb)
1. [Deploy](#deploy)
    1. [Deploy only MQTT2MongoDB](#deploy-only-mqtt2mongodb)
    2. [Deploy MQTT2MongoDB MQTT MongoDB](#deploy-mqtt2mongodb-mqtt-mongodb)
    3. [Debug with docker-compose](#debug-with-docker-compose)
    4. [Build and run as Daemon without mapping the appsettings file](#build-and-run-as-daemon-without-mapping-the-appsettings-file)
2. [Requirements](#requirements)
3. [Settings](#settings)
4. [Features](#features)
5. [Document Format in MongoDB](#document-format-in-mongodb)

## Requirements
- Python 3.x (tested on python:3.8-slim-buster in container)
- Tested on Docker with docker-compose on Mac OS Big Sur
- A working, available MQTT broker
- A working, available MongoDB server
- Libraries:
    * [pymongo](https://pypi.org/project/pymongo/)
    * [paho-mqtt](https://pypi.org/project/paho-mqtt/)
- Docker + docker-compose is recommended if available

----

## Settings
Settings for MQTT Broker and MongoDB server can be placed on the ***```appsettings.json```*** file.

----

## Features
- [x] Separated Threads for MQTT and MongoDB
- [x] MQTT with callback and subscribers list of topics
- [x] MongoDB with new thread for each save in MongoDB
- [x] Queue implemented to communicate data between MQTT and MongoDB
- [x] Decode JSON from MQTT message and save as Object in MongoDB
- [x] Save timestamp and datetime (ISO 8601) in Document which will be recognized as Date in MongoBD

---

## Document Format in MongoDB
When payload is a text will be something like
```json
{
    "_id": {
        "$oid": "6115d9581049eacf18f6cd9e"
    },
    "topic": "topic1/subtopic/teste",
    "payload": "Just some text, :)",
    "qos": 0,
    "timestamp": 1628821848,
    "datetime": "2021-08-13T02:30:48.807958"
}
```
Or when your payload is a json, the document in mongodb will be like below
```json
{
    "_id": {
        "$oid": "6115d9181049eacf18f6cd9d"
    },
    "topic": "topic1/subtopic/teste",
    "payload": {
        "key1": "value1",
        "key2": 2.5,
        "somelist": [
            "item1",
            "item2",
            "item3"
        ]
    },
    "qos": 0,
    "timestamp": 1628821784,
    "datetime": "2021-08-13T02:29:44.901154"
}
```
----
# Deploy
## Deploy only MQTT2MongoDB

```bash
curl -sS https://raw.githubusercontent.com/juniorsaldanha/MQTT2MongoDB/master/deploy.sh | bash -s only-mqtt2mongodb
```

---
## Deploy MQTT2MongoDB MQTT MongoDB
```bash
curl -sS https://raw.githubusercontent.com/juniorsaldanha/MQTT2MongoDB/master/deploy.sh | bash -s full
```

---
## Debug with docker-compose
To Debug with docker container and vscode use the command below, or if you have Docker extension on vscode just right-click on `docker-compose.debug.yml`
```bash
docker-compose -f "docker-compose.debug.yml" up --build -d
```
and use "Python: Remote Attach" on Debug option.

---

## Build and run as Daemon without mapping the appsettings file
To run as service on background use the command below
```bash
docker-compose -f "docker-compose.yml" up --build -d
```

