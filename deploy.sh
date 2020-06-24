docker build -t chary123/multi-client:latest -t chary123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chary123/multi-server:latest -t chary123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chary123/multi-worker:latest -t chary123/multi-worker:$SHA -f ./worker/Dockerfile ./worker    
docker push chary123/multi-client:latest
docker push chary123/multi-server:latest
docker push chary123/multi-worker:latest

docker push chary123/multi-client:$SHA
docker push chary123/multi-server:$SHA
docker push chary123/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=chary123/multi-server:$SHA
kubectl set image deployments/client-deployment client=chary123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chary123/multi-worker:$SHA