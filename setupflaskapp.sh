#!/bin/bash

# Configuración
APP_NAME="flask_app"
DOCKER_IMAGE_NAME="flask_app"
PORT=5000

echo "Creando directorio para la aplicación..."
mkdir $APP_NAME && cd $APP_NAME

echo "Configurando el entorno virtual..."
python3 -m venv venv
source venv/bin/activate

echo "Instalando Flask en el entorno virtual..."
pip install flask

echo "Guardando las dependencias en requirements.txt..."
pip freeze > requirements.txt

echo "Creando la aplicación Flask..."
cat <<EOL > app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "¡Hola! Bienvenido a mi aplicación Flask."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=$PORT)
EOL

echo "Creando el archivo Dockerfile..."
cat <<EOL > Dockerfile
# Usar la imagen base de Python 3.10
FROM python:3.10-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos necesarios al contenedor
COPY requirements.txt requirements.txt
COPY app.py app.py

# Instalar las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto 5000
EXPOSE $PORT

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
EOL

echo "Construyendo la imagen Docker..."
docker build -t $DOCKER_IMAGE_NAME .

echo "Ejecutando el contenedor Docker..."
docker run -d -p $PORT:$PORT $DOCKER_IMAGE_NAME

echo "La aplicación está corriendo en http://localhost:$PORT"
