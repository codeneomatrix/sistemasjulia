using Merly

server = Merly.app()

  @page "/" "Hello World!"

  @page "/camaras" begin
    h["Content-Type"]="application/json"
    JSON.json(listacam)
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

server.start("192.168.0.3", 8080)
