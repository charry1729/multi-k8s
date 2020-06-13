create client server folder invivially 
and create docker file 


3 repos ,, 3 dockerer build

client container
docker build -f Dockerfile.dev .
docker run 

server container
with node mon -- change in the Dockerfile its npm run dev
docker build -f Dockerfile.dev .
docker run 
 

and worker container

____________


in complex folder crate docker-compose yamlfile with postgrs and run post gre container
and redis container 

version : '3'
services:
  postgres:
    image: 'postgres:latest'
    environment :
      - POSTGRES_PASSWORD=password
  redis:
    image: 'redis:latest'
  
    
you can run postgres container in the documentation

if you want to start a database . better run in a container 

-e POSTGRES_PASSWORD=password

__________________________________________________________________________

and 3rd services is our server container 

mentions the dockerfile Dockerfile.dev server container 

path to the source server directory as context
build the image from this 

host name in the docker yaml means to 
service name in the yaml file -- pgHOST name is postgres

3 container new

redis
postgres
server


yest containers
nginx
client dev
client tests

+++++++++++++
total containers

nginx
 client react server
express server
worker
redis
postgres
+++++++++++++++++++
nginx helps in routing request to react client server and express server 

/index.html and main.js
will be routed to react client server 

so nginx adds  with '/api' and routes to react client server 

/values/all
/values/current will be routed to express server

nginx will be add '/' at start and express server 

in react server all the axios is requesting the api's to api/values/all 
in server its just /values/all

so the nginx server wil be adding the /api/ folder 

+++++++++++++++++

add default.conf 
this is nginx configuration 


tell nginx that threre is an upsteam servers

upsteam servers means =you cannot directly acces the react client and express server 
its has to be routed through nginx

so we mention these ports of upstream serers in the default.conf file 
server 5000 and client 3000

also listen to 80 
if anyone comes with / send to client 
if anyone comes with /api send to server stream 

define a new nginx folder 
+++++++++
upstream client {
    server client:3000;

}

upstream server {
    server server: 5000;
}

server {
    listen 80;
    location /{
        proxy_pass http://client;
    }
    location /api{
        rewrite /api/(.*) /$1 break;
        proxy_pass http://api;
    }
}

+++++++++++++++++++

and in the same folder create default,conf file and overwrite it in the Dockerfile                                                                                                                                                                                                              
FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf


also add the following to the docker-compose.yml file 
in the services 
  nginx:
    restart: always
    build :
      dockerfile : Dockerfile.dev
      context : ./nginx
    ports :
      - '3050:80'
  api : 

  so the whole yml will be 

version : '3'
services:
  postgres:
    image: 'postgres:latest'
    environment :
      - POSTGRES_PASSWORD=password
  redis:
    image: 'redis:latest'
  nginx:
    restart: always
    build :
      dockerfile : Dockerfile.dev
      context : ./nginx
    ports :
      - '3050:80'
    depends_on:
      - api
      - client

  api : 
    build : 
      dockerfile : Dockerfile.dev
      context : ./server
    volumes : 
        - /app/node_modules
        - ./server:/app
    environment :
        - REDIS_HOST=redis
        - REDIS_PORT=6379
        - PGUSER=postgres
        - PGHOST=postgres
        - PGPORT=5432
        - PGDATABASE=postgres
        - PGPASSWORD=password
    depends_on :
        - postgres
  client :
    build :
      dockerfile : Dockerfile.dev
      context : ./client
    volumes:
      - /app/node_modules
      - ./client:/app
    ports :
      - 3001:3000
  worker:
    build:
      dockerfile : Dockerfile.dev
      context: ./worker
    volumes:
    - /app/node_modules
    - ./worker:/app




++++++++++++++++
after updating the nginx build the docker aagain and make all the serices up 


__________________________


process to deploy on elastic bean stalk


push to github
travis pull the repo
travis build images 
test code(npm run test)
pushed to AWSEB
EB builds image again and deploys it web server 

______________
push to github
travis pull the repo
travis build test images 
test code(npm run test)
pushed to prod AWSEB
EB builds image again and deploys it web server 

______________

travis will push to your prod code images to own docker hub

____


