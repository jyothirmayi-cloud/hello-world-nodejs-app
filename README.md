

To design the infrastructure as code (IaC) for deploying a "Hello World" Node.js application using Terraform with AWS ECS/Fargate and set up a continuous deployment (CD) pipeline using GitHub Actions, we'll need to follow several steps:
1.	Terraform Configuration:
o	Set up the VPC, subnets, and security groups.
o	Create an ECS cluster.
o	Define the ECS task definition.
o	Create an ECS service.
o	Set up the IAM roles and policies.
o	Configure a load balancer (optional, but recommended for production).

2.	GitHub Actions Workflow:
•	Define the workflow to build the Docker image.
•	Push the Docker image to Amazon ECR.
•	Deploy the updated task definition to ECS.


	Directory Structure:

hello-world-nodejs-app/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── Dockerfile
├── index.js
├── package.json
└── terraform/
    ├── main.tf
    ├── vpc.tf
    ├── ecs.tf
    ├── iam.tf
    ├── ecs_service.tf
    ├── security_groups.tf
    └── ecr.tf

	Git commands:
Initialize the Repository
1.	Initialize a new Git repository

 

2.	Add all files to the repository:
 

3.	Commit the files:

 


4.	Add the remote repository:
 

5.	Push to GitHub:

 

	Prerequisites to start on project for permissions:
1.	Create AWS IAM User with Necessary Permissions 

First create an IAM user in AWS with programmatic access and the necessary permissions for ECS, ECR, and any other AWS services you plan to use. Assign the following policies to the user:

To create an AWS IAM user with the necessary permissions for ECS, ECR, and other AWS services, follow these steps:
Step 1: Create an IAM User
1.	Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/.
2.	In the navigation pane, choose Users and then select Add user.
3.	User details:
o	User name: Enter a user name, such as github-actions-user.
o	Access type: Select Programmatic access.
4.	Permissions: Choose Attach existing policies directly.
5.	Attach the following policies:
o	AmazonECSTaskExecutionRolePolicy
o	AmazonEC2ContainerRegistryFullAccess
o	AmazonEC2ContainerServiceFullAccess
You can add these policies by searching for them in the policy list and selecting them.
Step 2: Create Inline Policy for Additional Permissions
To ensure the user has the necessary permissions to manage ECS services and interact with ECR, create an inline policy:
1.	Select the user you created (e.g., github-actions-user).
2.	Go to the Permissions tab.
3.	Click Add inline policy.
4.	Choose the JSON tab.
5.	Paste the following policy document:
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeleteCluster",
        "ecs:DescribeClusters",
        "ecs:RegisterTaskDefinition",
        "ecs:DeregisterTaskDefinition",
        "ecs:DescribeTaskDefinition",
        "ecs:ListTaskDefinitions",
        "ecs:ListClusters",
        "ecs:CreateService",
        "ecs:UpdateService",
        "ecs:DeleteService",
        "ecs:DescribeServices",
        "ecs:ListServices",
        "iam:PassRole",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
        "ec2:DescribeSecurityGroups",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeListeners"
      ],
      "Resource": "*"
    }
  ]
}

6.Review and Create:
•	Click Review policy.
•	Give the policy a name, such as ECSInlinePolicy.
•	Click Create policy.
Step 3: Save Access Credentials
1.	After creating the user, you'll see a success message along with the Access key ID and Secret access key.
2.	Download the .csv file with the credentials or copy them to a secure location. You will need these credentials to configure the GitHub secrets.
Step 4: Configure GitHub Secrets
1.	Go to your GitHub repository and navigate to Settings.
2.	In the left sidebar, click on Secrets and variables, then Actions.
3.	Click the New repository secret button to add a new secret.
4.	Add the following secrets:
o	AWS_ACCESS_KEY_ID
	Name: AWS_ACCESS_KEY_ID
	Value: Your AWS Access Key ID from the IAM user you created.
o	AWS_SECRET_ACCESS_KEY
	Name: AWS_SECRET_ACCESS_KEY
	Value: Your AWS Secret Access Key from the IAM user you created.
GitHub Actions workflow will now be able to use these AWS credentials to authenticate and interact with AWS services.

have your Terraform backend bucket set up before running the workflow.

To set up your Terraform backend bucket on AWS S3 and configure the necessary permissions before running the workflow, follow these steps:
Step 1: Create an S3 Bucket for Terraform State
1.	Sign in to the AWS Management Console and open the S3 console at https://console.aws.amazon.com/s3/.
2.	Click Create bucket.
3.	Configure the bucket:
o	Bucket name: Enter a unique bucket name, such as your-terraform-state-bucket.
o	Region: Choose the same region you plan to use for your infrastructure, e.g., us-east-1.
4.	Click Create bucket.
Step 2: Enable Versioning on the S3 Bucket
1.	Open the S3 console and navigate to the bucket you just created.
2.	Click on the Properties tab.
3.	Scroll to the Bucket Versioning section and click Edit.
4.	Enable versioning and click Save changes.

	Check github workflow in below mentioned  link
Github action build screen:
 

For more details:
https://github.com/jyothirmayi-cloud/hello-world-nodejs-app

	AWS screenprints:


 

	 

	Final output:

 





