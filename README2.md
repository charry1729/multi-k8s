like nginx we have ingress service


this ingress service is conencted to clusterIP service
 one of server and one for client 

so in the deployment 
we have 3 client pods , 3 server pods

1 ClusterIP Service - Deployment - 3 multi-client-pod
1 ClusterIP Service - Deployment - 3 multi-server-pod

1 ClusterIP Service - Deployment - 1 redis-pod
1 ClusterIP Service - Deployment - 1 postgres-pod ----> Postgres PVC

Deployment - 1 multi-worker-pod

if another pod want to connect to the pod 
we should use NodePort Service--> 
port
targetPort
nodePort(random 30000-32767) -----> multi-client Pod

kubectl get deployments
kubectl delete deployment client-deployment

kubectl get services

NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
client-node-port   NodePort    10.108.213.195   <none>        3050:31515/TCP   2d22h
kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP          12d

kubectl delete service client-node-port 

persistant volume claim is just like a advertisement
actual allocation is not done yet
state provision is not done yet


access modes
:
ReadWriteOnce - can be used by sing;e node
ReadOnlyMany- multiple nodes can red from this

ReadWriteMany-can R/W by many nodes

default is harddrive
hostpath
k8s.io/minikube-hostpath

# ---

 kubectl get storageclass
NAME                 PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
standard (default)   k8s.io/minikube-hostpath   Delete          Immediate           false                  12d
chary@chary-Latitude-3490:~/docker$ kubectl describe storageclass
Name:            standard
IsDefaultClass:  Yes
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"},"labels":{"addonmanager.kubernetes.io/mode":"EnsureExists"},"name":"standard"},"provisioner":"k8s.io/minikube-hostpath"}
,storageclass.kubernetes.io/is-default-class=true
Provisioner:           k8s.io/minikube-hostpath
Parameters:            <none>
AllowVolumeExpansion:  <unset>
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     Immediate
Events:                <none>

# --
you can store in 

aws ElasticBlockStore
AzureFile
AzureDisk
NFS

volumes : alloate that storage
give the pvc name 

in containers--- use that storage
 subPath is a folder where it stotes

kubectl get pv

kubectl get pvc

__________

dev and prod

to store secrets 
will provide through cli 
command is 


kubectl create secret generic --name --from-literal key=value (PGPASSWORD=password)

generic -storing kv pairs

kubectl create secret docker-registry


kubectl create secret tls

https-setup 
set of tls keys

kubectl create secret generic pgpassword --from-literal PGPASSWORD=password

secret/pgpassword created
chary@chary-Latitude-3490:~/docker/complex2-k8s$ kubectl get secrets
NAME                  TYPE                                  DATA   AGE
default-token-mx6qs   kubernetes.io/service-account-token   3      13d
pgpassword            Opaque                                1      8s

# ----


update postgress pods

Load Balancer
https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud/deploy.yaml

https://kubernetes.github.io/ingress-nginx/deploy/#aws

https://www.joyfulbikeshedding.com/blog/2018-03-26-studying-the-kubernetes-ingress-system.html


google cloud load balancer

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud/deploy.yaml


aws load balancer

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/aws/deploy.yaml


minikube addons enable ingress
🌟  The 'ingress' addon is enabled

load balance service


kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud/deploy.yaml


kubectl get pods -n ingress-nginx
