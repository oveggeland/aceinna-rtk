from socket import *
import time

s=socket(AF_INET, SOCK_DGRAM)
s.bind(('0.0.0.0',137))

while True:
    m=s.recvfrom(1024)
    print (time.time())
