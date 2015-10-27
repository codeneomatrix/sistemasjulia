include("ffmpeg.jl")

using Mux

function leer(url)
  cadena=""
  open(url) do f1
    for linea in eachline(f1)
        cadena*= linea
    end
  end
  cadena
end

@app test = (
  Mux.defaults,
  page(respond(leer("/home/neomatrix/Escritorio/sistemasjulia/index.html"))),
  page("/about",
       probabilty(0.5, respond("<h1>Boo!</h1>")),
       respond("<h1>About Me</h1>")),
  page("/user/:user", req -> "<h1>Hello, $(req[:params][:user])!</h1>"),
  Mux.notfound())

serve(test)
