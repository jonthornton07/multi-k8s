 # Build docker images
 docker build -t jonthornton07/multi-client:latest -t jonthornton07/multi-client:$SHA -f ./client/Dockerfile.dev ./client
 docker build -t jonthornton07/multi-server:latest -t jonthornton07/multi-server:$SHA  -f ./server/Dockerfile.dev ./server
 docker build -t jonthornton07/multi-worker:latest -t jonthornton07/multi-worker:$SHA  -f ./worker/Dockerfile.dev ./worker

# Push docker images
docker push jonthornton07/multi-client:latest
docker push jonthornton07/multi-server:latest
docker push jonthornton07/multi-worker:latest
docker push jonthornton07/multi-client:$SHA
docker push jonthornton07/multi-server:$SHA
docker push jonthornton07/multi-worker:$SHA

# Apply all the k8s
kubectl apply -f k8s

# Set latest images
kubectl set image deployments/server-deployment server=jonthornton07/multi-server:$SHA
kubectl set image deployments/client-deployment client=jonthornton07/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jonthornton07/multi-worker:$SHA