# joing-infra
## AWS Infra IaC Repository - Terraform
### 모노레포 -- production만 테라폼으로 작성
### 서비스 별로

  - main.tf
  - outputs.tf
  - variables.tf
  - (op) security_group.tf
  - etc
### 보안 그룹, iam, subnet
  - 분리
  - 서비스마다 필요할 때 security_group.tf로 생성 -- 채택
  - 예외: subnet 모듈 분리 (R&R 분명히)
### 계정 IAM 관리
  - terraform 관리가 필요함
  - [aws-iam](https://github.com/KTB-6-Joing/aws-iam) 레포지토리로 분리 @uno 담당
### 비용 예측 및 태깅
  - 서비스마다 태그 달아서 비용 추적하기
  - 비용 예측
    - 예측 비용: 360$ ± 20$
    - 실제 비용: 403.57$ = 예측 범위 내
  <img width="1056" alt="image" src="https://github.com/user-attachments/assets/b14613e3-f8eb-498d-8295-5ca12e9e4cca" />

### 서비스 생성 관리
- EC2: redis-instance(프리티어)
- ECR: gen-ai, rec-ai, be
- EKS:
  - Cluster
  - NodeGroup: t3a.large ondemand 2, spot 2
    - jenkins cloud agent spot으로 띄울 예정 - 뜨는데 1분 소요
      - affinity: jenkins=true
- RDS: MySQL 8.0.39, db.t3.micro / public
- Subnet:
  - EC2: Public 1
  - EKS Cluster: Public 2
  - EKS NodeGroup: Public: medium 2 (a, c), spot 2 (a, c)
  - RDS: Public 2
    - DB Subnet Group
  - 개발 마감 후 Private 이전 예정
- VPC: VPC, IGW, RTB
- 로드밸런서 및 리스너: 별도 생성
  - 로드밸런서: Ingress ALB 자동 생성
  - 리스너: Ingress HTTPS 리스너 자동 생성
  - 로드밸런서 보안그룹: 80, 443 추가
- ACM 인증서: 별도 생성

- .tfvars, .tfstate S3에 백업

```
.
├── README.md
├── main.tf
├── modules
│   ├── ec2
│   ├── ecr
│   ├── eks
│   ├── rds
│   ├── subnet
│   └── vpc
├── outputs.tf
├── providers.tf
├── secret.tfvars
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
```
