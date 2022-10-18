# from typing import List
from datetime import datetime
from queue import Queue
import pymongo, threading
from time import sleep

class Mongo(object):
    def __init__(self, mongoConfig:dict, queue:Queue):
        self.__set_vars(mongoConfig)
        self.queue: Queue = queue
        self.client: pymongo.MongoClient = None
        self.database: pymongo.database.Database = None
        self.collection: pymongo.collection.Collection = None

    def __set_vars(self, config:dict):
        self.MONGO_HOST = config["HOST"]
        self.MONGO_PORT = config["PORT"]

        self.MONGO_USER = config["USER"] if config["USER"] else None
        self.MONGO_PASS = config["PASS"] if config["PASS"] else None

        self.MONGO_DB = config["DATABASE"]
        self.MONGO_COLLECTION = config["COLLECTION"]
        
        self.MONGO_TIMEOUT = config["TIMEOUT"]
        self.MONGO_DATETIME_FORMAT = "%d/%m/%Y %H:%M:%S"

    def connect(self,):
        print("Connecting Mongo")
        self.client = pymongo.MongoClient(
            host=self.MONGO_HOST,
            port=self.MONGO_PORT,
            authSource=self.MONGO_DB,
            username=self.MONGO_USER,
            password=self.MONGO_PASS,
            tls=True,
            tlsAllowInvalidCertificates=True
        )
        self.database = self.client.get_database(self.MONGO_DB)
        self.collection = self.database.get_collection(self.MONGO_COLLECTION)
        self.connected()

    def disconnect(self):
        print("Disconnecting Mongo")
        if self.client:
            self.client.close()
            self.client = None

    def connected(self) -> bool:
        if not self.client:
            return False
        try:
            self.client.admin.command("ismaster")
        except pymongo.errors.PyMongoError:
            return False
        else:
            return True

    def __enqueue(self, msg: dict):
        print("Enqueuing")
        self.queue.put(msg)

    def __sync_queue(self,):
        if self.queue.qsize():
            self.save(self.queue.get())
        else:
            sleep(0.05)

    def __store_thread_f(self, msg: dict):
        print("Storing")
        try:
            result = self.collection.insert_one(msg)
            print("Saved in Mongo document ID", result.inserted_id)
            if not result.acknowledged:
                # Enqueue message if it was not saved properly
                self.__enqueue(msg)
        except Exception as ex:
            print(ex)

    def __store(self, msg:dict):
        th = threading.Thread(target=self.__store_thread_f, args=(msg,))
        th.daemon = True
        th.start()

    def save(self, msg: dict):
        print("Saving")
        if self.connected():
            self.__store(msg)
        else:
            self.__enqueue(msg)

    def run(self,):
        while True:
            try:
                self.__sync_queue()
            except Exception as err:
                print(f"ERROR: {err}")
