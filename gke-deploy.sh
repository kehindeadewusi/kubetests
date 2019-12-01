docker build -t kehindeadewusi/mclient:latest -t kehindeadewusi/mclient:$SHA -f ./client/Dockerfile ./client
docker build -t kehindeadewusi/mserver:latest -t kehindeadewusi/mserver:$SHA -f ./server/Dockerfile ./server
docker build -t kehindeadewusi/mworker:latest -t kehindeadewusi/mworker:$SHA -f ./worker/Dockerfile ./worker

docker push kehindeadewusi/mclient:latest
docker push kehindeadewusi/mserver:latest
docker push kehindeadewusi/mworker:latest

docker push kehindeadewusi/mclient:$SHA
docker push kehindeadewusi/mserver:$SHA
docker push kehindeadewusi/mworker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=kehindeadewusi/mclient:$SHA
kubectl set image deployments/server-deployment server=kehindeadewusi/mserver:$SHA
kubectl set image deployments/worker-deployment worker=kehindeadewusi/mworker:$SHA
