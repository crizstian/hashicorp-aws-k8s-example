resource "aws_security_group" "node_group_one" {
  for_each    = local.k8s_vpcs
  name_prefix = "${each.key}_node_group_one"
  vpc_id      = module.vpc[each.key].vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "node_group_two" {
  for_each    = local.k8s_vpcs
  name_prefix = "${each.key}_node_group_two"
  vpc_id      = module.vpc[each.key].vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
}
