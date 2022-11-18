vpc_networks = {
  infrateam_vpc = {
    enable             = true
    vpc_cidr           = "10.0.0.0/16"
    private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
    enable_nat_gateway = true
  }
}