# ECS and ECR Tutorial

## 1. ECR Initialization with creating IAM Role
### 1.1. Enable AWS cli
    - aws-cli
    ```bash
    brew install aws-cli
    ```
    - amazon-ecs-cli
    ```bash
    brew install amazon-ecs-cli
    ```
### 1.2. Create IAM role to allow ECS tasks to call AWS services.
    - AmazonECSTaskExecutionRolePolicy
### 1.3. Create ECR Repository
    - ecs-test/my-fastapi-repo
    - ecs-test/my-fastapi-repo

## 2. build fastapi container and push to ECR
```bash
docker buildx build --platform linux/amd64 -t my-fastapi . --load

docker tag my-fastapi:latest <AWS_Account_ID>.dkr.ecr.us-east-2.amazonaws.com/ecs-test/my-fastapi-repo:latest

docker push <AWS_Account_ID>.dkr.ecr.us-east-2.amazonaws.com/ecs-test/my-fastapi-repo:latest
```


## 3. build nginx container and push to ECR
```bash
docker buildx build --platform linux/amd64 -t my-nginx ./nginx --load

docker tag my-nginx:latest <AWS_Account_ID>.dkr.ecr.us-east-2.amazonaws.com/ecs-test/my-nginx-repo:latest

docker push <AWS_Account_ID>.dkr.ecr.us-east-2.amazonaws.com/ecs-test/my-nginx-repo:latest
```
### ECS + Nginx Proxy Note
- **Fargate (awsvpc mode)**: same task containers share the ENI, so use  
  ```nginx
  proxy_pass http://127.0.0.1:8080;
  ```
- **EC2 launch type (bridge mode)**: containers have isolated network namespaces, so use service/container name DNS, e.g.
  ```nginx
  proxy_pass http://fastapi_server:8080;
  ```
## 4. create postgresql DB using AWS rds
### 4.1. configuration
- Publicly accessible: Yes
- Security Group Inbound: Anywhere for 5432 (postgresql port) 
- check connection with DBeaver

## 5. Create AWS ECS(Elastic Container Service) Cluster 
### 5.1. create log group in Cloud Watch with name [/ecs/my-ecs-task]
### 5.2. create ECS Cluster using CLI
```
aws ecs create-cluster --cluster-name my-ecs-cluster
```
### 5.3. create new task definition using CLI
```
aws ecs register-task-definition --cli-input-json file://task-definition.json
```
### 5.4. create ECS Service
```
aws ecs create-service \
    --cluster my-ecs-cluster \
    --service-name my-app-service \
    --task-definition my-app-task \
    --desired-count 1 \
    --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[subnet-06aa4642debb274e8
,subnet-0032e550936adb42c,subnet-0710e3e7f908004a1],securityGroups=[sg-0b79f89bbe61367cd],assignPublicIp=ENABLED}"
```
### 5.5. Access to publicIP

## 6. attach ALB for Load Balancer
### 6.1. Create Application Load Balancer (ALB) 
### 6.2. Create Target Group
- Choose a target type: IP Addresses
- Enter an IPv4 address from a VPC subnet: Private IP (=fargate IP)
    - cluster > service > tasks
- Add Target Group back in ALB Settings
### 6.3. After provisioning of ALB, Access to DNS (A Record)