region              = "us-east-1"
vpc_cidr            = "10.0.0.0/16"
azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
env                 = "dev"
instance_type       = "t2.small"
key_name            = "Ravi_Virginia"
instance_names      = ["Jenkins", "Docker", "Kubernetes"]
allowed_ports       = ["22", "80", "8080", "3306"]

