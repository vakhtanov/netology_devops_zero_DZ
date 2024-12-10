#!/usr/bin/env python
# coding=utf-8
import pika

from settings import URI

connection = pika.BlockingConnection(pika.URLParameters(URI))
channel = connection.channel()
channel.queue_declare(queue='hello')
channel.basic_publish(exchange='', routing_key='hello', body='Hello Netology!')
connection.close()
