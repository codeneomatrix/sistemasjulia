using Mux

@app test = (
  Mux.defaults,
  page(respond("<h1>Hello World!</h1>")),
  page("/about",
       probabilty(0.5, respond("<h1>Boo!</h1>")),
       respond("<h1>About Me</h1>")),
  page("/user/:user", req -> "<h1>Hello, $(req[:params][:user])!</h1>"),
  Mux.notfound())

serve(test)
