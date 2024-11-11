# joing-infra

- 모노레포 -- production만 테라폼으로 작성
- 서비스 별로
  - main.tf
  - outputs.tf
  - variables.tf
  - (op) security_group.tf
  - etc
- 보안 그룹, iam, subnet
  - 분리
  - 서비스마다 필요할 때 security_group.tf로 생성 -- 채택
  - 예외: subnet 모듈 분리 (R&R 분명히)
- 계정 IAM 관리
  - terraform 관리가 필요함
  - @uno 담당
- 태깅

  - 서비스마다 태그 달아서 비용 추적하기

- EC2: redis-instance(프리티어)
- ECR: gen-ai, rec-ai, be
  - (ai 통합 예정)
- EKS:
  - Cluster
  - NodeGroup: medium 2, medium-spot 2
    - jenkins agent spot으로 띄울 예정 - 뜨는데 1분 소요
      - affinity: jenkins=true
- RDS: MySQL 8.0.39, db.t3.micro / public
- Subnet:
  - EC2: Public 1
  - EKS Cluster: Public 2
  - EKS NodeGroup: Public: medium 2 (a, c), spot 2 (a, c)
  - RDS: Public 2
    - DB Subnet Group
- VPC: VPC, IGW
- 로드밸런서 및 리스너: 별도 생성
  - 로드밸런서: Ingress ALB 자동 생성
  - 리스너: HTTPS 리스터 생성
  - 로드밸런서 보안그룹: 80, 443 추가
- ACM 인증서: 별도 생성

  - jenkins
  -

- .tfvars, .tfstate S3에 백업

```
.
├── README.md
├── main.tf
├── modules
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
