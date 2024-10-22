# joing-infra

- 작은데 모노레포로 쓰자
- 서비스 별로
  - main.tf
  - outputs.tf
  - variables.tf
- 보안 그룹, iam, subnet
  - 분리
  - 서비스마다 필요할 때 security_group.tf로 생성 -- 채택
- 계정 IAM 관리
  - terraform 관리가 필요함
  - @uno 담당
- 태깅
  - 서비스마다 태그 달아서 비용 추적하기
