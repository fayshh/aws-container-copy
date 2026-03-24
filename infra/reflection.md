# Terraform Reflection

## 1. Why were import blocks important in this lab?

Import blocks were important because most of the AWS resources were already created in earlier assignments. Terraform needed a way to recognize those existing resources instead of trying to create new ones. By using import blocks and the correct resource IDs, Terraform was able to bring those resources into its state and start managing them.

If the infrastructure had been created with Terraform from the beginning, import blocks would not be needed because Terraform would have created and tracked the resources itself.

## 2. Why didn’t you use Terraform to manage secrets in Parameter Store?

Terraform stores information about infrastructure in a state file. If secrets were managed through Terraform, those values could end up in the state file, which could be a security risk.

Because of that, Terraform was only used for non-sensitive values like IDs. Secrets should usually be managed separately unless the Terraform state is stored securely with proper access controls.