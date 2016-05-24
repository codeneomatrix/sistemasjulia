import requests,json,base64
from io import BytesIO

def main():
  response = requests.get('http://localhost:5000')
  return response

#with open("asin.jpg", "rb") as image_file:  #codificar imagen a base64 a partir de archivo
#    encoded_string = base64.b64encode(image_file.read())

#datos={"imagen":encoded_string}
#print(type(encoded_string))

if __name__ == '__main__':
	for x in range(5):
		print("obteniendo imagen "+str(x))
		url = 'http://127.0.0.1:5000/getImage'
		r = requests.get(url)
		if r.status_code==200:
			deco=base64.b64decode(r.text)

			with open("cliente/asinc"+str(x)+".jpg", 'wb') as f:  #se guarda en un archivo de imagen
				f.write(deco)
