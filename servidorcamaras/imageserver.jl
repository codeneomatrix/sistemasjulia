include("ffmpeg.jl")
using HttpServer

#listacam=()
http = HttpHandler() do req::Request, res::Response
  
      if ismatch(r"^/camara1/", req.resource)
        reqsplit = split(req.resource, "/")
        # ...snip validation...#
        probstr = reqsplit[3]
        if probstr == "video"
          return Response(200, 
        """<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
            <s:Header />
            <s:Body>
              <videoResponse xmlns="http://tempuri.org/">
                <videoResult xmlns:a="http://schemas.datacontract.org/2004/07/imageservice" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">
                  <a:dominio>camara1</a:dominio>
                  <a:ffplay>ffplay udp://192.168.1.11:8090/camara1</a:ffplay>
                  <a:ip>192.168.1.11</a:ip>
                  <a:protocolo>udp</a:protocolo>
                  <a:puerto>8090</a:puerto>
                </videoResult>
              </videoResponse>
            </s:Body>
          </s:Envelope>""")
        end
        if probstr == "datos"
          return Response(200, "mostrando los datos de la camara1")
        end
      end
      if ismatch(r"^/camaras/", req.resource)
        reqsplit = split(req.resource, "/")
        # ...snip validation...#
        probstr = reqsplit[3]
        if probstr == "nuevo"
          return Response(200, 
        """<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
            <s:Header />
            <s:Body>
              <NuevaCamaraResponse xmlns="http://tempuri.org/">
                <NuevaCamaraResult>true</NuevaCamaraResult>
              </NuevaCamaraResponse>
            </s:Body>
          </s:Envelope>""")
          #cam1 = Cam("camara1","admin","","192.168.1.12")
          #push!(listacam, cam1)
        end
        if probstr == ""
           return Response(200, 
        """<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
            <s:Header>
              <Action s:mustUnderstand="1" xmlns="http://schemas.microsoft.com/ws/2005/05/addressing/none">http://tempuri.org/Icamaras/ObtenerCamara</Action>
            </s:Header>
            <s:Body>
              <ObtenerCamara xmlns="http://tempuri.org/" />
            </s:Body>
          </s:Envelope>
          respuesta
          <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
            <s:Header />
            <s:Body>
              <ObtenerCamaraResponse xmlns="http://tempuri.org/">
                <ObtenerCamaraResult xmlns:a="http://schemas.datacontract.org/2004/07/imageservice" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">
                  <a:Camara>
                    <a:contraseña />
                    <a:ip>192.168.1.10</a:ip>
                    <a:nombre>camara1</a:nombre>
                    <a:usuario>admin</a:usuario>
                  </a:Camara>
                </ObtenerCamaraResult>
              </ObtenerCamaraResponse>
            </s:Body>
          </s:Envelope>""")
        end
        if probstr == "delete"
          return Response(200, 
        """<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
            <s:Header />
            <s:Body>
              <EliminarCamaraResponse xmlns="http://tempuri.org/">
                <EliminarCamaraResult>true</EliminarCamaraResult>
              </EliminarCamaraResponse>
            </s:Body>
          </s:Envelope>""")
        end
      else
        # Not a valid URL
        return Response(404)
  end
end

server = Server( http )
run(server, host=IPv4(192,168,0,4), port=9000)