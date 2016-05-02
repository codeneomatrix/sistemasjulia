import cv2
import urllib 
import numpy as np

stream=urllib.urlopen('http://201.166.63.44/axis-cgi/mjpg/video.cgi')
bytes=''
while True:
    bytes+=stream.read(16384)
    a = bytes.find('\xff\xd8')
    b = bytes.find('\xff\xd9')
    if a!=-1 and b!=-1:
        jpg = bytes[a:b+2]
        bytes= bytes[b+2:]
        i = cv2.imdecode(np.fromstring(jpg, dtype=np.uint8),cv2.IMREAD_COLOR)
        cv2.imshow('i',i)
        if cv2.waitKey(1) ==27:
            exit(0)    