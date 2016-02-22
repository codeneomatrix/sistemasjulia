using Nettle
type Cam
	nombre::AbstractString
	usuario::AbstractString
	contra::AbstractString
	ip::AbstractString
end

type Aplicacion
  nombre::AbstractString
  camaras 
end

type Usuario
  nombre::AbstractString
  contra::AbstractString
  telefono::AbstractString
  correo::AbstractString
  aplicaciones
end



function optvideo(x)
  Dict(
   "http"=>"http://$(x.usuario):$(x.contra)@$(x.ip)/video/mjpg.cgi",
   "udp"=>"ffmpeg -i http://$(x.usuario):$(x.contra)@$(x.ip)/video/mjpg.cgi?profile=1 -f mpegts udp://192.168.1.11:8090/$(x.nombre) ")
end

function optimg(x)
  run(`ffmpeg -i http://$(x.usuario):$(x.contrase)@$(x.ip)/video/mjpg.cgi?profile=1 -frames:v 1 -ss 00:00:00 -f image2 im.png`)
  s = open("im.png")
  #base64encode("hola")
  #base64decode
#using Images
#using Colors
#using FixedPointNumbers
#using ImageView
#img = load("im.png")
  Dict(
   "http"=>"http://$(x.usuario):$(x.contra)@$(x.ip)/image/jpeg.cgi"
    )
end

global listacam=[]
global listaapp=[]
global listausr=[]