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
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
