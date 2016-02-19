from flask import Flask,request
from flask.ext.cors import CORS
import numpy
import subprocess as sp
import base64
from PIL import Image
from io import BytesIO
import cStringIO

app = Flask(__name__)
#CORS(app)
@app.after_request
def add_cors(resp):
	resp.headers['Access-Control-Allow-Origin']=request.headers.get('origin')
	resp.headers['Access-Control-Allow-Credentials']='true'
	resp.headers['Access-Control-Allow-Methods']='GET'
	resp.headers['Access-Control-Allow-Headers']=request.headers.get('Access-Control-Request-Headers','Authorization')

	if app.debug:
		resp.headers['Access-Control-Max-Age']='1'
	return resp



def read(fuente,ancho,alto): 
	command = [ "ffmpeg",
    	        #'-i', 'http://187.174.218.180:83/mjpg/video.mjpg?COUNTER',
        	    #'-ss', '00:03:12',
            	'-i',fuente,
            	'-f', 'image2pipe',
            	'-pix_fmt', 'rgb24',
            	'-vcodec', 'rawvideo', '-']
	pipe = sp.Popen(command, stdout = sp.PIPE, bufsize=10**8)
	raw_image = pipe.stdout.read(ancho*alto*3)
	
	image =  numpy.fromstring(raw_image, dtype='uint8')

	image = image.reshape((alto,ancho,3))
	

	img = Image.fromarray(image, 'RGB')
	
	img.save('my.png')
	
	with open("my.png", "rb") as image_file:  #codificar imagen a base64 a partir de archivo
		encoded_string = base64.b64encode(image_file.read())
	pipe.terminate()
	return encoded_string


def toGray(img):#recibe como parametro un String es decir una imagen codificada en base64
	im = Image.open(BytesIO(base64.b64decode(img))) #convierte la cadena recibida a un objeto Image
	pixel=im.load()  #load() regresa una matriz de pixeles(con tuplas)
	ancho=im.size[0]  #se obtiene el ancho de la imagen
	alto=im.size[1]  #se obtiene el alto de la imagen
	for i in range(ancho):   #se recorre la imagen para cambiar los pixeles a gray
		for j in range(alto):
			gray=(pixel[i,j][0]+pixel[i,j][1]+pixel[i,j][2])/3
			pixel[i,j]=(gray,gray,gray)


	buffer = cStringIO.StringIO()  #se crea un buffer en ram a partir del objeto PIL Image
	im.save(buffer, format="JPEG")  #se guarda el buffer con formato jpeg
	return base64.b64encode(buffer.getvalue())   # se regresa el buffer codificado en base64



@app.route('/')
def index():
    return "Hello, World!"

@app.route('/funciones/toGray',methods=["POST"])
def funcion1():
	if request.headers["accept"]=="application/json":
		if not "imagen" in request.json:
			abort(400)
		img=request.json["imagen"]
		img=toGray(img)
		return  img

@app.route('/getImage',methods=["GET"])
def funcion2():
	#img=read("http://187.217.216.173:80/mjpg/video.mjpg?COUNTER",480,360)
	img=read("http://admin:Oaxaca123@192.168.1.171/video/mjpg.cgi?profile=2",640,352)
	img=toGray(img)

	return  img


if __name__ == '__main__':
    app.run(debug=True)
