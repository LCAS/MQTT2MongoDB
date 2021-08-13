from json.decoder import JSONDecodeError
from typing import Dict
from datetime import datetime
from queue import Queue
import paho.mqtt.client as mqtt
import json

class MQTT(object):
    def __init__(self, mqttConfig:dict, queue:Queue):
        self.__set_vars(mqttConfig)
        self.queue: Queue = queue
        self.mqtt_client = mqtt.Client()
        self.mqtt_client.on_connect = self.on_connect
        self.mqtt_client.on_message = self.on_message

    def __set_vars(self, config:dict):
        self.MQTT_BROKER = config["HOST"]
        self.MQTT_PORT = config["PORT"]
        self.MQTT_KEEPALIVE = config["KEEPALIVE"]
        self.MQTT_QOS = config["QOS"]
        self.MQTT_TOPICS = config["TOPICS"]

    # noinspection PyUnusedLocal
    # @staticmethod
    def on_connect(self, client: mqtt.Client, userdata, flags, rc):
        print("Connected MQTT")
        print("Connected with result code "+str(rc))
        for topic in self.MQTT_TOPICS:
            client.subscribe(topic, self.MQTT_QOS)

    # noinspection PyUnusedLocal
    def on_message(self, client: mqtt.Client, userdata, msg: mqtt.MQTTMessage):
        if not msg.retain:
            data = self.__createMsg(msg)
            print(f"Rx MQTT | msg: {data}")
            self.queue.put(data)

    def run(self):
        print(f"Running MQTT | BROKER: {self.MQTT_BROKER} PORT:{self.MQTT_PORT}")
        self.mqtt_client.connect(
            host=self.MQTT_BROKER,
            port=self.MQTT_PORT,
            keepalive=self.MQTT_KEEPALIVE)
        self.mqtt_client.loop_start()

    def stop(self):
        print("Stopping MQTT")
        self.mqtt_client.loop_stop()
        self.mqtt_client.disconnect()

    def __createMsg(self, msg: mqtt.MQTTMessage) -> dict:
        return dict({
            "topic": msg.topic,
            "payload": self.__checkJsonInPayload(msg.payload),
            # "retained": msg.retain,
            "qos": msg.qos,
            "timestamp": int(datetime.now().timestamp()),
            "datetime": datetime.now().isoformat(),
        })
    
    def __checkJsonInPayload(self, payload:bytes):
        data = payload.decode(encoding="utf-8")
        try:
            return json.loads(data)
        except JSONDecodeError:
            return data
