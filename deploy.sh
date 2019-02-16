docker build -t studentaleksandr/multi-client:latest -t studentaleksandr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t studentaleksandr/multi-server:latest -t studentaleksandr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t studentaleksandr/multi-worker:latest -t studentaleksandr/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push studentaleksandr/multi-client:$SHA
docker push studentaleksandr/multi-server:$SHA
docker push studentaleksandr/multi-worker:$SHA
docker push studentaleksandr/multi-client:latest
docker push studentaleksandr/multi-server:latest
docker push studentaleksandr/multi-worker:latest
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=studentaleksandr/multi-server:$SHA
kubectl set image deployments/client-deployment client=studentaleksandr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=studentaleksandr/multi-worker:$SHA