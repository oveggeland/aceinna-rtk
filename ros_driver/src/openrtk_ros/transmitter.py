"""
Simple network transmitter for ethernet debugging
"""

from socket import *
s=socket(AF_INET, SOCK_DGRAM)
s.setsockopt(SOL_SOCKET, SO_BROADCAST, 1)
s.sendto('this is testing'.encode(),('192.168.1.255',137))