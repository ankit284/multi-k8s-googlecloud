docker build -t ankitsinghai/multi-client:latest -t ankitsinghai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ankitsinghai/multi-server:latest -t ankitsinghai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ankitsinghai/multi-worker:latest -t ankitsinghai/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ankitsinghai/multi-client:latest
docker push ankitsinghai/multi-server:latest
docker push ankitsinghai/multi-worker:latest

docker push ankitsinghai/multi-client:$SHA
docker push ankitsinghai/multi-server:$SHA
docker push ankitsinghai/multi-worker:$SHA  

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ankitsinghai/multi-server:$SHA
kubectl set image deployments/client-deployment client=ankitsinghai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ankitsinghai/multi-worker:$SHA

