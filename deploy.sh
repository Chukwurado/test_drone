echo $google_credentials > /tmp/$CI_PIPELINE_ID.json
gcloud auth activate-service-account --key-file /tmp/$CI_PIPELINE_ID.json
gcloud config set project test-k8s-287319
gcloud config set compute/zone us-central1-c
gcloud components install kubectl
gcloud container clusters get-credentials cluster-1
kubectl apply -f k8s
kubectl set image deployments/server-deployment server="chukwurado/multi-server:${DRONE_COMMIT_SHA:0:7}"
kubectl set image deployments/client-deployment client="chukwurado/multi-client:${DRONE_COMMIT_SHA:0:7}"
kubectl set image deployments/worker-deployment worker="chukwurado/multi-worker:${DRONE_COMMIT_SHA:0:7}"