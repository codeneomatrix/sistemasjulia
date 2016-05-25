from Tkinter import *
from PIL import Image
from PIL import ImageTk
import tkFileDialog
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
#instancia de la maquina de vector de  soporte para la deteccion de personas
hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())
#recibe dos listas de 6 elementos las cuales son los datetime inicial y final

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
	global i
	print "Enviando imagen a Telegram ..."
	tb.send_message(221660416,"Persona detectada a las: "+band.hora)
	img = Image.fromarray(i, 'RGB')
	img.save('my.png')
	photo=open('my.png', 'rb')
	tb.send_photo(221660416,photo)
	band.flag=True
	print "Envio Exitoso!!!"

#stream=urllib.urlopen('http://k133-200.mgmt.purdue.edu/axis-cgi/mjpg/video.cgi?camera=&amp;resolution=640x480')
#stream=urllib.urlopen('http://orion02.bglb.jp:8080/nphMotionJpeg?Resolution=640x480&Quality=Motion')
#stream=urllib.urlopen('http://plottercam.wmbinc.com/mjpg/video.mjpg')
#stream=urllib.urlopen('http://77.48.31.68/mjpg/video.mjpg')
#"http://golfetangsale.axiscam.net:81/mjpg/video.mjpg"
def camara():
	global panelA
	h1=str(hora_i.get()).split(':');
	h2=str(hora_f.get()).split(':');
	
	band.fechainit[3]=int(h1[0])
	band.fechainit[4]=int(h1[1])
	band.fechafin[3]=int(h2[0])
	band.fechafin[4]=int(h2[1])

	stream=urllib.urlopen(str(urlcamara.get()))
	bytes=''
	while True:
		bytes+=stream.read(16384)
		a = bytes.find('\xff\xd8')
		b = bytes.find('\xff\xd9')
		if a!=-1 and b!=-1:
			jpg = bytes[a:b+2]
			bytes= bytes[b+2:]
			global i
			i = cv2.imdecode(np.fromstring(jpg, dtype=np.uint8),cv2.IMREAD_COLOR)
			# deteccion de las personas en la imagen
			(rects, weights) = hog.detectMultiScale(i,winStride=(4, 4),padding=(8, 8),scale=1.05)
			if len(rects)>1 and band.flag and checkHour(band.fechainit,band.fechafin):
				w = threading.Thread(target=peticion)
				w.start()
				band.flag=False
			for rect in rects:
				cv2.putText(i, str(len(rects))+" personas", (10,30),cv2.FONT_HERSHEY_DUPLEX, 1, (0, 255, 255), 3)
				cv2.rectangle(i, (rect[0], rect[1]), (rect[0] + rect[2] , rect[1] + rect[3]), (255, 255, 0), 5)
				cv2.putText(i, "Persona", (rect[0], rect[1]),cv2.FONT_HERSHEY_DUPLEX, 1, (0, 255, 255), 3)
			#cv2.imshow('Hawkcam (video)',i)
			image = Image.fromarray(i)
			image = ImageTk.PhotoImage(image)
			if panelA is None:
				panelA = Label(image=image)
				panelA.image = image
				panelA.pack(side="left", padx=10, pady=10)
			else:
				panelA.configure(image=image)
				panelA.image = image
				root.update()
			#if cv2.waitKey(1) ==27:
			#	exit(0)
  
root = Tk()
root.title("Hawkcam")
panelA = None
panelB = None
 
etiqueta = Label(root, text="Configuracion de alertas: ",font=("Helvetica", 16))
etiqueta.pack()

etiqueta = Label(root, text="Camara: ",justify=LEFT)
etiqueta.pack()

valor = ""
urlcamara = Entry(root, width=50, textvariable=valor)
urlcamara.insert(0, "http://orion02.bglb.jp:8080/nphMotionJpeg?Resolution=640x480&Quality=Motion")
urlcamara.pack()


etiqueta = Label(root, text="Hora de inicio: ")
etiqueta.pack()
hora_i = Entry(root, width=8, textvariable=valor)
hora_i.insert(0, "11:00")
hora_i.pack()

etiqueta = Label(root, text="Hora de fin: ")
etiqueta.pack()
hora_f = Entry(root, width=8, textvariable=valor)
hora_f.insert(0, "12:00")
hora_f.pack()

boton = Button(root, text="Iniciar", command=camara)
boton.pack()

 
root.mainloop()
