docker build -t mattre/multi-client:latest -t mattre/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mattre/multi-server:latest -t mattre/multi-client:$SHA -f ./server/Dockerfile ./server
docker build -t mattre/multi-worker:latest -t mattre/multi-client:$SHA -f ./worker/Dockerfile ./worker

docker push mattre/multi-client:latest
docker push mattre/multi-server:latest
docker push mattre/multi-worker:latest

docker push mattre/multi-client:$SHA
docker push mattre/multi-server:$SHA
docker push mattre/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mattre/multi-server:$SHA
kubectl set image deployments/client-deployment client=mattre/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mattre/multi-worker:$SHA