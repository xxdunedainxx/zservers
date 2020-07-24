locals = {
  cluster_name                 = "zkube-cluster.zee-aws.net"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-west-2a-masters-zkube-cluster-zee-aws-net.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"]
  masters_role_arn             = "${aws_iam_role.masters-zkube-cluster-zee-aws-net.arn}"
  masters_role_name            = "${aws_iam_role.masters-zkube-cluster-zee-aws-net.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-zkube-cluster-zee-aws-net.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"]
  node_subnet_ids              = ["${aws_subnet.us-west-2a-zkube-cluster-zee-aws-net.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-zkube-cluster-zee-aws-net.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-zkube-cluster-zee-aws-net.name}"
  region                       = "us-west-2"
  route_table_public_id        = "${aws_route_table.zkube-cluster-zee-aws-net.id}"
  subnet_us-west-2a_id         = "${aws_subnet.us-west-2a-zkube-cluster-zee-aws-net.id}"
  vpc_cidr_block               = "${aws_vpc.zkube-cluster-zee-aws-net.cidr_block}"
  vpc_id                       = "${aws_vpc.zkube-cluster-zee-aws-net.id}"
}

output "cluster_name" {
  value = "zkube-cluster.zee-aws.net"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-west-2a-masters-zkube-cluster-zee-aws-net.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-zkube-cluster-zee-aws-net.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-zkube-cluster-zee-aws-net.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-zkube-cluster-zee-aws-net.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-west-2a-zkube-cluster-zee-aws-net.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-zkube-cluster-zee-aws-net.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-zkube-cluster-zee-aws-net.name}"
}

output "region" {
  value = "us-west-2"
}

output "route_table_public_id" {
  value = "${aws_route_table.zkube-cluster-zee-aws-net.id}"
}

output "subnet_us-west-2a_id" {
  value = "${aws_subnet.us-west-2a-zkube-cluster-zee-aws-net.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.zkube-cluster-zee-aws-net.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.zkube-cluster-zee-aws-net.id}"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_autoscaling_group" "master-us-west-2a-masters-zkube-cluster-zee-aws-net" {
  name                 = "master-us-west-2a.masters.zkube-cluster.zee-aws.net"
  launch_configuration = "${aws_launch_configuration.master-us-west-2a-masters-zkube-cluster-zee-aws-net.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-zkube-cluster-zee-aws-net.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "zkube-cluster.zee-aws.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-2a.masters.zkube-cluster.zee-aws.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-west-2a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-zkube-cluster-zee-aws-net" {
  name                 = "nodes.zkube-cluster.zee-aws.net"
  launch_configuration = "${aws_launch_configuration.nodes-zkube-cluster-zee-aws-net.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-zkube-cluster-zee-aws-net.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "zkube-cluster.zee-aws.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.zkube-cluster.zee-aws.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-zkube-cluster-zee-aws-net" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "a.etcd-events.zkube-cluster.zee-aws.net"
    "k8s.io/etcd/events"                              = "a/a"
    "k8s.io/role/master"                              = "1"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-zkube-cluster-zee-aws-net" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "a.etcd-main.zkube-cluster.zee-aws.net"
    "k8s.io/etcd/main"                                = "a/a"
    "k8s.io/role/master"                              = "1"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-zkube-cluster-zee-aws-net" {
  name = "masters.zkube-cluster.zee-aws.net"
  role = "${aws_iam_role.masters-zkube-cluster-zee-aws-net.name}"
}

resource "aws_iam_instance_profile" "nodes-zkube-cluster-zee-aws-net" {
  name = "nodes.zkube-cluster.zee-aws.net"
  role = "${aws_iam_role.nodes-zkube-cluster-zee-aws-net.name}"
}

resource "aws_iam_role" "masters-zkube-cluster-zee-aws-net" {
  name               = "masters.zkube-cluster.zee-aws.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.zkube-cluster.zee-aws.net_policy")}"
}

resource "aws_iam_role" "nodes-zkube-cluster-zee-aws-net" {
  name               = "nodes.zkube-cluster.zee-aws.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.zkube-cluster.zee-aws.net_policy")}"
}

resource "aws_iam_role_policy" "masters-zkube-cluster-zee-aws-net" {
  name   = "masters.zkube-cluster.zee-aws.net"
  role   = "${aws_iam_role.masters-zkube-cluster-zee-aws-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.zkube-cluster.zee-aws.net_policy")}"
}

resource "aws_iam_role_policy" "nodes-zkube-cluster-zee-aws-net" {
  name   = "nodes.zkube-cluster.zee-aws.net"
  role   = "${aws_iam_role.nodes-zkube-cluster-zee-aws-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.zkube-cluster.zee-aws.net_policy")}"
}

resource "aws_internet_gateway" "zkube-cluster-zee-aws-net" {
  vpc_id = "${aws_vpc.zkube-cluster-zee-aws-net.id}"

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "zkube-cluster.zee-aws.net"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-zkube-cluster-zee-aws-net-d942bf9d3ff77bfd74955e178b43a657" {
  key_name   = "kubernetes.zkube-cluster.zee-aws.net-d9:42:bf:9d:3f:f7:7b:fd:74:95:5e:17:8b:43:a6:57"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.zkube-cluster.zee-aws.net-d942bf9d3ff77bfd74955e178b43a657_public_key")}"
}

resource "aws_launch_configuration" "master-us-west-2a-masters-zkube-cluster-zee-aws-net" {
  name_prefix                 = "master-us-west-2a.masters.zkube-cluster.zee-aws.net-"
  image_id                    = "ami-0a6203cdbf824b92c"
  instance_type               = "m3.medium"
  key_name                    = "${aws_key_pair.kubernetes-zkube-cluster-zee-aws-net-d942bf9d3ff77bfd74955e178b43a657.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-zkube-cluster-zee-aws-net.id}"
  security_groups             = ["${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-2a.masters.zkube-cluster.zee-aws.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  ephemeral_block_device = {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral0"
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-zkube-cluster-zee-aws-net" {
  name_prefix                 = "nodes.zkube-cluster.zee-aws.net-"
  image_id                    = "ami-0a6203cdbf824b92c"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-zkube-cluster-zee-aws-net-d942bf9d3ff77bfd74955e178b43a657.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-zkube-cluster-zee-aws-net.id}"
  security_groups             = ["${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.zkube-cluster.zee-aws.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.zkube-cluster-zee-aws-net.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.zkube-cluster-zee-aws-net.id}"
}

resource "aws_route_table" "zkube-cluster-zee-aws-net" {
  vpc_id = "${aws_vpc.zkube-cluster-zee-aws-net.id}"

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "zkube-cluster.zee-aws.net"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
    "kubernetes.io/kops/role"                         = "public"
  }
}

resource "aws_route_table_association" "us-west-2a-zkube-cluster-zee-aws-net" {
  subnet_id      = "${aws_subnet.us-west-2a-zkube-cluster-zee-aws-net.id}"
  route_table_id = "${aws_route_table.zkube-cluster-zee-aws-net.id}"
}

resource "aws_security_group" "masters-zkube-cluster-zee-aws-net" {
  name        = "masters.zkube-cluster.zee-aws.net"
  vpc_id      = "${aws_vpc.zkube-cluster-zee-aws-net.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "masters.zkube-cluster.zee-aws.net"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
  }
}

resource "aws_security_group" "nodes-zkube-cluster-zee-aws-net" {
  name        = "nodes.zkube-cluster.zee-aws.net"
  vpc_id      = "${aws_vpc.zkube-cluster-zee-aws-net.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "nodes.zkube-cluster.zee-aws.net"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  source_security_group_id = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  source_security_group_id = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  source_security_group_id = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  source_security_group_id = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  source_security_group_id = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  source_security_group_id = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  source_security_group_id = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-zkube-cluster-zee-aws-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-zkube-cluster-zee-aws-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-west-2a-zkube-cluster-zee-aws-net" {
  vpc_id            = "${aws_vpc.zkube-cluster-zee-aws-net.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-west-2a"

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "us-west-2a.zkube-cluster.zee-aws.net"
    SubnetType                                        = "Public"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
    "kubernetes.io/role/elb"                          = "1"
  }
}

resource "aws_vpc" "zkube-cluster-zee-aws-net" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "zkube-cluster.zee-aws.net"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "zkube-cluster-zee-aws-net" {
  domain_name         = "us-west-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                                 = "zkube-cluster.zee-aws.net"
    Name                                              = "zkube-cluster.zee-aws.net"
    "kubernetes.io/cluster/zkube-cluster.zee-aws.net" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "zkube-cluster-zee-aws-net" {
  vpc_id          = "${aws_vpc.zkube-cluster-zee-aws-net.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.zkube-cluster-zee-aws-net.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
