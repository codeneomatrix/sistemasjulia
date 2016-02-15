using Merly

#lu=[Usuario("juan","hola",[Aplicacion("apli",["cam1","cam2"])])]
#lu[1].aplicaciones[1].camaras

# {"nombre":"yo",
#    "contra":"ki",
#        "aplicaciones":[{"nombreapp":"apli","camaras":["cam1","cam2"]}]}

server = Merly.app()

  @page "/" "Hello World!"

  @page "/camaras" begin
    h["Content-Type"]="application/json"
    JSON.json(listacam)
  end

  @page "/usuarios" begin
    h["Content-Type"]="application/json"
    JSON.json(listausr)
  end

  @page "/usuarios/:nombre/aplicaciones" begin
    h["Content-Type"]="application/json"
    for i=listausr[1:end]
       if i.nombre==params["nombre"]
          return JSON.json(i.aplicaciones)
       end
    end
    return "[{}]"
  end

  @page "/camaras/:nombre" begin
    h["Content-Type"]="application/json"
    println("params: ",params)
    for i=listacam[1:end]
       if i.nombre==params["nombre"]
         return JSON.json(i)
       end
    end
    return "[{}]"
  end

  @page "/usuarios/:nombre" begin
    h["Content-Type"]="application/json"
    println("params: ",params)
    for i=listausr[1:end]
       if i.nombre==params["nombre"]
         return JSON.json(i)
       end
    end
    return "[{}]"
  end

  @page "/camaras/:nombre/video" begin
    h["Content-Type"]="application/json"
    println("params: ",params)
    for i=listacam[1:end]
       if i.nombre==params["nombre"]
         return JSON.json(optvideo(i))
       end
    end
    return "[{}]"
  end

  @route POST "/camaras" begin
    h["Content-Type"]="application/json"
    println("body: ",body)
    try
      nombren=body["nombre"]
      push!(listacam,Cam(nombren,body["usuario"],body["contra"],body["ip"]))
      h["Location"]="/camaras/"*nombren
      res.status= 201
    catch
      res.status= 400
    end
  end

  @route POST "/usuarios" begin
    h["Content-Type"]="application/json"
    println("body: ",body)
    
    la=[]
    try
      nombren=body["nombre"]
      
      
        for i=body["aplicaciones"][1:end]
          push!(la,Aplicacion(i["nombreapp"],i["camaras"]))
        end
      

      push!(listausr,Usuario(nombren,hexdigest("md5", string(body["contra"])),la))
      h["Location"]="/usuarios/"*nombren
      res.status= 201
    catch
      res.status= 400
    end
  end

  @route PUT "/camaras/:nombre" begin
    h["Content-Type"]="application/json"
    println("params: ",params)
    println("body: ",body)
    try

      for i=listacam[1:end]
         if i.nombre==params["nombre"]
          i.nombre=body["nombre"]
          i.usuario=body["usuario"]
          i.contra=body["contra"]
          i.ip=body["ip"]
         end
      end

      res.status=200
    catch
      res.status=400
    end
  end

  @route PUT "/usuarios/:nombre" begin
    h["Content-Type"]="application/json"
    println("params: ",params)
    println("body: ",body)
    la=[]
    try

      for i=body["aplicaciones"][1:end]
          push!(la,Aplicacion(i["nombreapp"],i["camaras"]))
      end

      for i=listausr[1:end]
         if i.nombre==params["nombre"]
          i.nombre=body["nombre"]
          i.contra=hexdigest("md5", string(body["contra"]))
          i.aplicaciones=la
         end
      end

      res.status=200
    catch
      res.status=400
    end
  end

  @route DELETE "/camaras/:nombre" begin
    h["Content-Type"]="application/json"
    println("params: ",params)
		try
      for i=1:length(listacam)
         if listacam[i].nombre==params["nombre"]
           splice!(listacam,i)
           res.status=200
           return ""
         end
      end
    catch
			res.status=400
		end
  end

  @route DELETE "/usuarios/:nombre" begin
    h["Content-Type"]="application/json"
    println("params: ",params)
    try
      for i=1:length(listausr)
         if listausr[i].nombre==params["nombre"]
           splice!(listausr,i)
           res.status=200
           return ""
         end
      end
    catch
      res.status=400
    end
  end

server.start("192.168.0.2", 8080)
