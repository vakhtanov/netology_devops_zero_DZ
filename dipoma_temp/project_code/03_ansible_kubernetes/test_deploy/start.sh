kubectl apply -n netology -f deployment-backend.yaml -f deployment-frontend.yaml -f service-backend.yaml -f service-frontend.yaml  
kubectl apply -f ingress.yaml -n netology
