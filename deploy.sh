docker build -t bhargavsnv/multi-client:latest -t bhargavsnv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bhargavsnv/multi-server:latest -t bhargavsnv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bhargavsnv/multi-worker:latest -t bhargavsnv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bhargavsnv/multi-client:latest
docker push bhargavsnv/multi-server:latest
docker push bhargavsnv/multi-worker:latest

docker push bhargavsnv/multi-client:$SHA
docker push bhargavsnv/multi-server:$SHA
docker push bhargavsnv/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bhargavsnv/multi-client:$SHA
kubectl set image deployments/server-deployment server=bhargavsnv/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bhargavsnv/multi-worker:$SHA
