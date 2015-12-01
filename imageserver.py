import SOAPpy
import os
#os.system('ffmpeg -i http://admin:Oaxaca123@192.168.1.12/video/mjpg.cgi\?profileid\=3 -f mpegts udp://192.168.1.11:8090/camara1')
class Camara:
    def __init__(self, i, nom, usu, con):
        self.ip = i
        self.nombre = nom
        self.usuario = usu
        self.contrasena= con


class Streaming:
    def __init__(self,pro, ii, pu, dom, ff):
        self.protocolo=pro
        self.ip=ii
        self.puerto= pu
        self.dominio= dom
        self.ffplay= ff

#puerto=8090;
a = []
#NuevaCamara("192.168.1.10","camara1","admin","", "123")
def NuevaCamara(ip,nombre,user,contra, key):
    if key=="123":
        a.append (Camara(ip,nombre,user,contra))
        return True
    else:
        return False

def ObtenerCamara():
    return str(a)

def EliminarCamara(nom, key):
    if key=="123":
        for i in range(len(a)):
            if a[i].nombre==nom:
                del a[i]
                return True
            else:
                return False
    else:
        return False

#str(a[0].nombre)
def video(nom):
    vidcam=""
    sesion=""
    for i in range(len(a)):
            if a[i].nombre==nom:
                vidcam=a[i]
    nes= Streaming("udp","192.168.1.11", "8090", vidcam.nombre, "ffplay udp://192.168.1.11:8090/" + vidcam.nombre)
    sesion = "ffmpeg -i http://"+vidcam.usuario+":"+vidcam.contrasena+"@"+vidcam.ip+"/video/mjpg.cgi -f mpegts "+nes.protocolo+"://"+nes.ip+":"+nes.puerto+"/"+nes.dominio;
    print(sesion)
    return nes


server = SOAPpy.SOAPServer(("192.168.1.11", 8080))
server.registerFunction(NuevaCamara)
server.registerFunction(ObtenerCamara)
server.registerFunction(EliminarCamara)
server.registerFunction(video)
server.serve_forever()


