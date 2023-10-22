docker build -t huckford/multi-client:latest -t huckford/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t huckford/multi-server:latest -t huckford/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t huckford/multi-worker:latest -t huckford/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push huckford/multi-client:latest
docker push huckford/multi-server:latest
docker push huckford/multi-worker:latest

docker push huckford/multi-client:$SHA
docker push huckford/multi-server:$SHA
docker push huckford/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=huckford/multi-server:$SHA
kubectl set image deployments/client-deployment client=huckford/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=huckford/multi-worker:$SHA