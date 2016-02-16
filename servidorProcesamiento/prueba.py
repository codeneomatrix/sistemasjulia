def binario(array):
	print("binario sobre el array",array)

def otsu(array):
	print("otsu sobre el array",array)





class Filtro:
    def __init__(self, func):
        self.ejecuta = func  


fil = Filtro(binario)

numbers = range(1, 10) # Lista del 1 al 9


print fil.ejecuta(numbers) 


#cambiamos la funcion
fil = Filtro(otsu)
print fil.ejecuta(numbers) 