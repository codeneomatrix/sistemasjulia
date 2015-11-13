include("ffmpeg.jl")
using HttpServer


tstr = """
<GeocodeResponse>
 <status>OK</status>
 <result>
  <type>street_address</type>
  <formatted_address>1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA</formatted_address>
  <address_component>
   <long_name>1600</long_name>
   <short_name>1600</short_name>
   <type>street_number</type>
  </address_component>
  <address_component>
   <long_name>Amphitheatre Pkwy</long_name>
   <short_name>Amphitheatre Pkwy</short_name>
   <type>route</type>
  </address_component>
  <address_component>
   <long_name>Mountain View</long_name>
   <short_name>Mountain View</short_name>
   <type>locality</type>
   <type>political</type>
  </address_component>
  <address_component>
   <long_name>San Jose</long_name>
   <short_name>San Jose</short_name>
   <type>administrative_area_level_3</type>
   <type>political</type>
  </address_component>
  <address_component>
   <long_name>Santa Clara</long_name>
   <short_name>Santa Clara</short_name>
   <type>administrative_area_level_2</type>
   <type>political</type>
  </address_component>
  <address_component>
   <long_name>California</long_name>
   <short_name>CA</short_name>
   <type>administrative_area_level_1</type>
   <type>political</type>
  </address_component>
  <address_component>
   <long_name>United States</long_name>
   <short_name>US</short_name>
   <type>country</type>
   <type>political</type>
  </address_component>
  <address_component>
   <long_name>94043</long_name>
   <short_name>94043</short_name>
   <type>postal_code</type>
  </address_component>
  <geometry>
   <location>
    <lat>37.4217550</lat>
    <lng>-122.0846330</lng>
   </location>
   <location_type>ROOFTOP</location_type>
   <viewport>
    <southwest>
     <lat>37.4188514</lat>
     <lng>-122.0874526</lng>
    </southwest>
    <northeast>
     <lat>37.4251466</lat>
     <lng>-122.0811574</lng>
    </northeast>
   </viewport>
  </geometry>
  <place_id>ChIJ2eUgeAK6j4ARbn5u_wAGqWA</place_id>
 </result>
</GeocodeResponse>
"""
#listacam=()
http = HttpHandler() do req::Request, res::Response
  
      if ismatch(r"^/camara1/", req.resource)
        reqsplit = split(req.resource, "/")
        # ...snip validation...#
        probstr = reqsplit[3]
        if probstr == "video"
          return Response(200, "video por fflay rts://192.168.1.11:8090/camara1")
        end
        if probstr == "datos"
          return Response(200, "mostrando los datos de la camara1")
        end
        return Response(tstr)
      end
      if ismatch(r"^/camaras/", req.resource)
        reqsplit = split(req.resource, "/")
        # ...snip validation...#
        probstr = reqsplit[3]
        if probstr == "nuevo"
          return Response(200, "nueva camara $(reqsplit[3])")
          #cam1 = Cam("camara1","admin","","192.168.1.12")
          #push!(listacam, cam1)
        end
        if probstr == ""
          return Response(200, "mostrando todas las camaras")
        end
        if probstr == "delete"
          return Response(200, "eliminado camara $(reqsplit[3])")
        end
        return Response(tstr)
      else
        # Not a valid URL
        return Response(404)
  end
end

server = Server( http )
run(server, host=IPv4(192,168,0,3), port=8000)