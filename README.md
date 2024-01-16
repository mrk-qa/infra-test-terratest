# Terratest Framework using Terraform to provision infrastructure on AWS ☁️👷


<div align="center"><img width="800px"  src="https://github.com/mrk-qa/infra-test-terratest/blob/90c550725f6e592cdec0679a1cf7a2ba1045c17b/assets/terraform_terratest_githubactions.png">
</div>

    
```
Project structure:
resources
  |-- db
  |   |-- terraform code
  |-- s3
  |   |-- terraform code
  |-- vm
  |   |-- terraform code
   
tests
  |-- reports
  |   |-- index.html
  |-- *db_test.go
  |-- *s3_test.go
  |-- *vm_test.go
```