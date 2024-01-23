# Terratest Framework using Terraform to provision infrastructure on AWS ☁️👷

<div align="center"><img width="800px"  src="https://github.com/mrk-qa/infra-test-terratest/blob/90c550725f6e592cdec0679a1cf7a2ba1045c17b/assets/terraform_terratest_githubactions.png">
</div>

------

## ✅ Requirements

- [terraform] - v 1.6.6
- [golang] - v 1.21.6
- [terratest] - v 0.46.9
- [hashicorp/aws] provider using in ec2 - v 5.31.0
- [hashicorp/aws] provider using in lambda - v 5.31.0
- [hashicorp/aws] provider using in s3 - v 5.16.0
- [go-test-report] - v 0.9.3

## 📑 Test Project Structure

```
resources
  |-- ec2
  |   |-- terraform code
  |-- lambda
  |   |-- terraform code
  |-- s3
  |   |-- terraform code
   
tests
  |-- reports
  |   |-- index.html
  |-- *ec2_test.go
  |-- *lambda_test.go
  |-- *s3_test.go
```

## 🔮 Support this project  

If you want to support this project, leave a ⭐.  

---  

Made with 💙 &nbsp;by Marco Antonio 👋 &nbsp; [Meu LinkedIn](https://www.linkedin.com/in/mrk-silva/)  