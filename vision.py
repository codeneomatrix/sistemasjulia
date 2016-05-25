import cv2
import urllib
import numpy as np
import threading
from datetime import datetime, date, timedelta
import telebot
from PIL import Image

class Flag():
    flag=True
    hora=""
    fechainit=[2016,5,25,1,30,12]
    fechafin=[2016,5,25,1,45,12]


band=Flag()
#instancia de api de telegram
TOKEN='187037777:AAHx9qke0YQtgeOJAYlwQdLjdtMaVbZj8zw'
tb=telebot.TeleBot(TOKEN)

hog = cv2.HOGDescriptor()
# Set the support vector machine to be pre-trained for people detection
hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())
#recibe dos listas de 6 elementos las cuales son los datetime inicial y final
#Ejemplo:checkHour([2016,5,24,17,45,12],[2016,5,12,18,45,12])
#-------------------anio--mes-dia-hora-minutos-seg
def checkHour(inicial,final):
    fecha = datetime.now().date()
    hora= datetime.now().time()

    fecha_dada = datetime(inicial[0],inicial[1],inicial[2],inicial[3],inicial[4],inicial[5])
    fecha_inicial = fecha_dada.date()
    hora_inicial=fecha_dada.time()

    fecha_dada1 = datetime(final[0],final[1],final[2],final[3],final[4],final[5])
    hora_final=fecha_dada1.time()

    fecha_final = fecha_dada1.date()
    if fecha_inicial <= fecha and fecha<=fecha_final:
        if hora_inicial<=hora and hora<=hora_final:
            band.hora=str(hora)
            return True
            #tb.send_message(221660416,"Persona detectada a las: "+str(hora))
    else:
        return False

def peticion():
    print "Telegram"
    tb.send_message(221660416,"Persona detectada a las: "+band.hora)
    img = Image.fromarray(i, 'RGB')
    img.save('my.png')
    photo = open('my.png', 'rb')
    tb.send_photo(221660416,photo)
    band.flag=True



#stream=urllib.urlopen('http://k133-200.mgmt.purdue.edu/axis-cgi/mjpg/video.cgi?camera=&amp;resolution=640x480')
stream=urllib.urlopen('http://orion02.bglb.jp:8080/nphMotionJpeg?Resolution=640x480&Quality=Motion')
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

        if len(rects)>0 and band.flag and checkHour(fechainit,fechafin):
            w = threading.Thread(target=peticion)
            w.start()
            band.flag=False

        if cv2.waitKey(1) ==27:
            exit(0)
