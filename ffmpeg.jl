
type Cam
	nombre::String
	usuario::String
	contra::String
	ip::String
	duracion::String
	ubicacionv::String
	ubicacioni::String
	imagen::Function
	video::Function
end

function optvideo(x::Cam)
	run(`ffmpeg -re -i http://$(x.usuario):$(x.contra)@$(x.ip)/video.cgi -ss 00:00:00 -t $(x.duracion) -c copy -y $(x.ubicacionv)`)
	#=
	-------------------------------------------------------------video---------------------------------
	ffmpeg -re -i http://admin:@192.168.1.10/video.cgi -ss 00:00:00 -t 00:00:10 -c copy -y /home/neomatrix/Escritorio/vi.avi
	<img style="-webkit-user-select: none" src="http://192.168.1.10/video.cgi">
	=#
	print("ffmpeg -re -i http://$(x.usuario):$(x.contra)@$(x.ip)/video.cgi -ss 00:00:00 -t $(x.duracion) -c copy -y $(x.ubicacionv)")
end

function optimg(x::Cam)
	run(`ffmpeg -i http://$(x.usuario):$(x.contrase)@$(x.ip)/video.cgi -frames:v 1 -ss 00:00:00 -f image2 $(x.ubicacioni)`)
	#=	
	--------------------------------------------------------------imagen---------------------------
	ffmpeg -i http://admin:@192.168.1.10/video.cgi -frames:v 1 -ss 00:00:00 -f image2 /home/neomatrix/Escritorio/imagen2.jpg
																							--- experimental
	ffmpeg -i http://admin:@192.168.1.10/image/jpeg.cgi /home/neomatrix/Escritorio/imagen2.jpg

	<img style="-webkit-user-select: none" src="http://192.168.1.10/image/jpeg.cgi">
	=#
	print("imagen!!!")
end

cam1 = Cam("c1","admin","","192.168.1.12","00.00.10","/home/neomatrix/Escritorio/vi.avi","/home/neomatrix/Escritorio/imagen2.jpg",optimg,optvideo)


##de la trendnet-------------------------------------------------------------------------------------------------
#<img style="-webkit-user-select: none" src="http://192.168.1.13/image/jpeg.cgi">
#<img style="-webkit-user-select: none" src="http://192.168.1.10/video/mjpg.cgi">
#ffmpeg -re -i http://admin:Oaxaca123@192.168.1.13/video/mjpg.cgi -ss 00:00:00 -t 00:00:10 -c copy -y /home/neomatrix/Escritorio/vi.avi
#hay un problema!!!!: Invalid data found when processing input