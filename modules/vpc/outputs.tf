output "vpc_id" {
  value = aws_vpc.main.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "igw_rtb_id" {
  value = aws_route_table.igw_rtb.id
}