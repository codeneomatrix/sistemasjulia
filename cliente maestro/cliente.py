import SOAPpy
server = SOAPpy.SOAPProxy("http://192.168.0.3:8080/")
print server.NuevaCamara("192.168.1.10","camara1","admin","", "123")
print server.ObtenerCamaras()
print server.video("camara1")
print server.NuevoUsuario("user1","admin",["camara1"],"123")
print server.ObtenerUsuarios()
cam= server.ObtenerCamara("camara1","user1","admin")
print server.video(cam.nombre)