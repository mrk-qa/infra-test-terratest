# Framework Terratest utilizando o Terraform para provisionar a infra na AWS ☁️👷

<div align="center"><img width="600px"  src="https://github.com/mrk-qa/infra-test-terratest/blob/92be9f641492d7768e65e3398251cbe1c9f794c2/assets/terraform_terratest_githubactions.png">
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