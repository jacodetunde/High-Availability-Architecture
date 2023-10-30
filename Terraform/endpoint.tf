resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "com.amazonaws.us-west-2.s3"

  tags = {
    Environment = "myEndPoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "endpoint1" {
  route_table_id = aws_route_table.private_route_table1.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "endpoint2" {
  route_table_id  = aws_route_table.private_route_table2.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}