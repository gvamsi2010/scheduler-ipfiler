# Automating AWS Managed Prefix List Updates Using AWS Lambda and Terraform

As cloud infrastructure scales, managing IP address access becomes increasingly complex. AWS provides Managed Prefix Lists, which are lists of CIDR blocks that can be shared across multiple resources in your AWS account. Automating the update process of these lists can save time and reduce the risk of errors. In this project, we automate the update of AWS Managed Prefix Lists using AWS Lambda and Terraform.

## Features

- **Automated Updates**: Automatically update AWS Managed Prefix Lists based on changes in specified data sources.
- **AWS Lambda Function**: Utilize AWS Lambda for serverless execution of the update process.
- **Infrastructure as Code**: Manage AWS resources using Terraform for easy provisioning and management.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/gvamsi2010/scheduler-managed-prefix-list.git
    ```

2. Navigate to the project directory:

    ```bash
    cd scheduler-managed-prefix-list
    ```

3. Set up your AWS credentials and Terraform configurations.

4. Customize the Lambda function code and Terraform configurations as needed.

5. Deploy the infrastructure using Terraform:

    ```bash
    terraform init
    terraform apply
    ```

6. Monitor and manage the deployed resources through the AWS Management Console or CLI.

## Contributing

Contributions are welcome! Please feel free to submit issues, fork the repository, and create pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

