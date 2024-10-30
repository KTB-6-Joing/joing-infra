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

- ECR: gen-ai, rec-ai, be
- EKS: Cluster, NodeGroup (medium 2, micro 1, spot 1)
- RDS: MySQL 8.0.39, micro
- Subnet:
  - EKS Cluster: Public 2
  - EKS NodeGroup:
    - Public: medium 1
    - Private: medium 1 micro 1, spot 1
  - RDS: Public 2
    - DB Subnet Group
- VPC: VPC, IGW
