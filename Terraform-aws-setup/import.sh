#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [ ! -f .terraform.lock.hcl ]; then
  terraform init
fi

import_if_missing() {
  local addr="$1"
  local id="$2"
  if terraform state show "$addr" >/dev/null 2>&1; then
    echo "skip import $addr (already in state)"
  else
    terraform import "$addr" "$id"
  fi
}

import_if_missing aws_vpc.my_vpc vpc-0b9c1cfb78bb9ab97
import_if_missing aws_subnet.my_subnet_01 subnet-06819156241f89ea5
import_if_missing aws_subnet.my_subnet_02 subnet-0080026223019bd69
import_if_missing aws_subnet.my_subnet_private_1 subnet-05d86ddecc86264e7
import_if_missing aws_internet_gateway.my_igw igw-022a8d736d14d9a31
import_if_missing aws_route_table.my_route_table_main rtb-08b40b141cd6718bd
import_if_missing aws_route_table.my_route_table_public rtb-0224cb3a5113daff8
import_if_missing aws_route_table.my_route_table_private rtb-0acf475682ff9eea5
import_if_missing aws_route_table_association.public_subnet_01 subnet-06819156241f89ea5/rtb-0224cb3a5113daff8
import_if_missing aws_route_table_association.public_subnet_02 subnet-0080026223019bd69/rtb-0224cb3a5113daff8
import_if_missing aws_route_table_association.private_subnet_1 subnet-05d86ddecc86264e7/rtb-0acf475682ff9eea5
import_if_missing aws_instance.blog_ec2 i-0e68962c0d6121d85

echo "Imported yesterday's UI-created resources into Terraform state."
echo "Run 'terraform plan' to verify that the imported configuration matches AWS."
