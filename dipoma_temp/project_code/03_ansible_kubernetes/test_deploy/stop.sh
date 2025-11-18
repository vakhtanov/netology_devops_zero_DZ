kubectl delete -n netology -f deployment-backend.yaml -f deployment-frontend.yaml -f service-backend.yaml -f service-frontend.yaml 
kubectl delete -f ingress.yaml -n netology
