
type Cam
	nombre::AbstractString
	usuario::AbstractString
	contra::AbstractString
	ip::AbstractString
end

function optvideo(x)
  Dict(
   "http"=>"http://$(x.usuario):$(x.contra)@$(x.ip)/video/mjpg.cgi",
   "udp"=>"ffmpeg -i http://$(x.usuario):$(x.contra)@$(x.ip)/video/mjpg.cgi?profile=1 -f mpegts udp://192.168.1.11:8090/$(x.nombre) ")
end

function optimg(x)
  Dict(
   "http"=>"http://$(x.usuario):$(x.contra)@$(x.ip)/image/jpeg.cgi"
    )
end

global listacam=[]