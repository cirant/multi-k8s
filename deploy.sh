docker build -t cirant3/multi-client:latest -t cirant3/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cirant3/multi-server:latest -t cirant3/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cirant3/multi-worker:latest -t cirant3/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cirant3/multi-client:latest
docker push cirant3/multi-server:latest
docker push cirant3/multi-worker:latest

docker push cirant3/multi-client:$SHA
docker push cirant3/multi-server:$SHA
docker push cirant3/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cirant3/multi-server:$SHA
kubectl set image deployments/client-deployment client=cirant3/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cirant3/multi-worker:$SHA