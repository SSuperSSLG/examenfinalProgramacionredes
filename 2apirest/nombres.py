import json

# Cargar el archivo JSON
with open('usuarios.json', 'r', encoding='utf-8') as archivo:
    usuarios = json.load(archivo)

# Extraer y mostrar los nombres de los usuarios
print("Lista de nombres de usuarios:")
for usuario in usuarios:
    nombre = usuario.get("nombre", "Nombre no disponible")
    print(f"- {nombre}")
