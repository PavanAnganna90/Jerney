# AWS UI Yesterday Import

This workspace imports the AWS resources created in the Console yesterday:

- `aws_vpc.my_vpc` — `vpc-0b9c1cfb78bb9ab97`
- `aws_subnet.my_subnet_01` — `subnet-06819156241f89ea5`
- `aws_subnet.my_subnet_02` — `subnet-0080026223019bd69`
- `aws_subnet.my_subnet_private_1` — `subnet-05d86ddecc86264e7`
- `aws_internet_gateway.my_igw` — `igw-022a8d736d14d9a31`
- `aws_route_table.my_route_table_main` — `rtb-08b40b141cd6718bd`
- `aws_route_table.my_route_table_public` — `rtb-0224cb3a5113daff8`
- `aws_route_table.my_route_table_private` — `rtb-0acf475682ff9eea5`
- `aws_main_route_table_association.main` — `rtbassoc-042a32ceb922faeb8`
- `aws_route_table_association.public_subnet_01` — `rtbassoc-00e90693640a1a635`
- `aws_route_table_association.public_subnet_02` — `rtbassoc-04c6529f87acf7e21`
- `aws_route_table_association.private_subnet_1` — `rtbassoc-09be383de74157c58`
- `aws_instance.blog_ec2` — `i-0e68962c0d6121d85`

Note: The instance references the existing security group `sg-09f3c55526065d0f1` by ID, rather than managing that security group resource directly in this workspace.

## Usage

```bash
cd Jerney/aws-ui-yesterday-import
bash import.sh
terraform plan
```

If the plan shows no changes, the imported configuration is consistent with the existing resources.
