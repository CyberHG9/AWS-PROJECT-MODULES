#!/bin/bash
# Actualizar paquetes
sudo dnf update -y

# Instalar Nginx y Docker
sudo dnf install -y nginx docker

# Habilitar e iniciar Docker
sudo systemctl enable docker
sudo systemctl start docker

# Habilitar e iniciar Nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Configurar Nginx como proxy inverso
cat <<EOF | sudo tee /etc/nginx/conf.d/nodeapp.conf
server {
    listen 80;
    location / {
        proxy_pass http://localhost:8080;
    }
}
EOF

# Eliminar el archivo de configuración por defecto (para evitar conflictos)
sudo rm -f /etc/nginx/conf.d/default.conf
sudo systemctl restart nginx

# Correr aplicación Node dentro de Docker
sudo docker run -d -p 8080:8080 --name nodeapp node:18-slim /bin/bash -c "
  echo 'const http=require(\"http\");const s=http.createServer((req,res)=>{res.writeHead(200,{\"Content-Type\":\"text/plain\"});res.end(\"OK\")});s.listen(8080,()=>console.log(\"Server running\"));' > app.js &&
  node app.js
"
