#PHASE 1 -> build bundle that needs deploying
#builder es un tag para nombrar a la imagen -> arbitrario
FROM node:16-alpine as builder

#creo el directorio '/app' y me paro ahí
WORKDIR '/app'

#me traigo el 'pom'
COPY package.json . 

#instalo dependencies
RUN npm install

#me traigo el source code mio
COPY . .

#buildeo
RUN npm run build
#el 'bundle' se va a guardar en /app/build

#PHASE 2 -> run nginx and serve the bundle previously created
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
#no need to run a command to start ngingx since the default command of the image is to start it