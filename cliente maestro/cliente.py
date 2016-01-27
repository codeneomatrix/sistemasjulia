import SOAPpy
server = SOAPpy.SOAPProxy("http://192.168.0.3:8080/")
print server.NuevaCamara("192.168.1.10","camara1","admin","", "123")
print server.ObtenerCamara()
print server.video("camara1")
