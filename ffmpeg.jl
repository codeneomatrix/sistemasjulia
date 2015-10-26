
type Cam
	nombre::String
	ip::String
	duracion::String
	ubicacion::String
	tamaño::String
	imagen::Function
	video::Function
end

function optvideo(x::Cam)
#=
-------------------------------------------------------------video---------------------------------
ffmpeg -re -i http://admin:@192.168.1.10/video.cgi -ss 00:00:00 -t 00:00:10 -c copy -y /home/neomatrix/Escritorio/vi.avi
<img style="-webkit-user-select: none" src="http://192.168.1.10/video.cgi">
=#
print("video!!!")
end

function optimg(x::Cam)
#=	
--------------------------------------------------------------imagen------------------------------ experimental
ffmpeg -i http://admin:@192.168.1.10/video.cgi -frames:v 1 -ss 00:00:00 -f image2 /home/neomatrix/Escritorio/imagen2.jpg

ffmpeg -i http://admin:@192.168.1.10/image/jpeg.cgi /home/neomatrix/Escritorio/imagen2.jpg

<img style="-webkit-user-select: none" src="http://192.168.1.10/image/jpeg.cgi">
=#
print("imagen!!!")
end

cam1 = Cam("c1","192.168.1.12","00.00.10","/home/neomatrix/Escritorio/vi.avi", "1366X768",optimg,optvideo)



