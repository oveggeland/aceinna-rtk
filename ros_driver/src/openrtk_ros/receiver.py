"""
Simple network receiver for ethernet debugging
"""

from socket import *
import time

s=socket(AF_INET, SOCK_DGRAM)
s.bind(('0.0.0.0',137))

while True:
    m=s.recvfrom(1024)
    print ("Received message at:", time.time())
