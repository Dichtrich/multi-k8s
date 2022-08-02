docker build -t dichtrich/multi-client:latest -t dichtrich/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dichtrich/multi-server:latest -t dichtrich/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dichtrich/multi-worker:latest -t dichtrich/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dichtrich/multi-client:latest
docker push dichtrich/multi-client:$SHA

docker push dichtrich/multi-server:latest
docker push dichtrich/multi-server:$SHA

docker push dichtrich/multi-worker:latest
docker push dichtrich/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=dichtrich/multi-server:$SHA
kubectl set image deployments/client-deployment client=dichtrich/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dichtrich/multi-worker:$SHA