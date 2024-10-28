// 생성하고 확인해야하는 ouput 값 작성
// 가능하면 로컬에 해당 값은 백업하기

output "DB_ENDPOINT" {
  value       = module.rds.joing_mysql_endpoint
  description = "joing MySQL RDS Endpoint"
}