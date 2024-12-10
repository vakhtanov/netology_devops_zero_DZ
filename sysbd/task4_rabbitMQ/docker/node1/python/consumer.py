#!/usr/bin/env python
# coding=utf-8
import pika

from settings import URI

connection = pika.BlockingConnection(pika.URLParameters(URI))
channel = connection.channel()
#channel.queue_declare(queue='hello')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume(
    on_message_callback=callback, 
    queue='hello', 
    auto_ack=True,
    consumer_tag="netology_consumer",
    )
channel.start_consuming()
