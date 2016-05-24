import cv2
import urllib 
import numpy as np

hog = cv2.HOGDescriptor()
# Set the support vector machine to be pre-trained for people detection
hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())

stream=urllib.urlopen('http://k133-200.mgmt.purdue.edu/axis-cgi/mjpg/video.cgi?camera=&amp;resolution=640x480')
bytes=''
while True:
    bytes+=stream.read(16384)
    a = bytes.find('\xff\xd8')
    b = bytes.find('\xff\xd9')
    if a!=-1 and b!=-1:
        jpg = bytes[a:b+2]
        bytes= bytes[b+2:]
        i = cv2.imdecode(np.fromstring(jpg, dtype=np.uint8),cv2.IMREAD_COLOR)        
        # Detect people in the image
        (rects, weights) = hog.detectMultiScale(i,winStride=(4, 4),padding=(8, 8),scale=1.05)
        for rect in rects:
        	cv2.rectangle(i, (rect[0], rect[1]), (rect[0] + rect[2] , rect[1] + rect[3]), (255, 255, 0), 5)
        	cv2.putText(i, "Persona", (rect[0], rect[1]),cv2.FONT_HERSHEY_DUPLEX, 1, (0, 255, 255), 3)
        cv2.imshow('i',i)
        if cv2.waitKey(1) ==27:
            exit(0)    