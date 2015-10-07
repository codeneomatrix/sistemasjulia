app = Morsel.app()

route(app, GET | POST | PUT, "/") do req, res
    "Esta es una simple prueba de tu existencia, morsel"
end

get(app, "/about") do req, res
    "This app is running on Morsel"
end

start(app, 8000)