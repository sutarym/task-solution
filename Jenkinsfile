pipeline {
  agent any
  environment {
    SUBNET_ID = sh(returnStdout: true, script: 'terraform output -raw subnet_id')
  }
  stages {
   stage('Checkout') {
            steps {
               
                git branch: 'main', url: 'https://github.com/sutarym/Task.git'
            }
        }

    
    stage('Init') {
       steps {
                
                sh 'terraform init'
            }
    }

    stage('Set ENV') {
            steps {
               
                environment {
    SUBNET_ID = sh(returnStdout: true, script: 'terraform output -raw subnet_id')
  }
            }
        }


    stage('Plan') {
      steps {
        bat 'terraform plan'
      }
    }

    stage('Apply') {
      steps {
        bat 'terraform apply -auto-approve'
      }
    }
 
     /*  
    stage('Destroy') {
      steps {
        bat 'terraform destroy -auto-approve'
      }
    }
       
 */  

    stage('Invoke Lambda Function') {
      
      steps {
        script {
          sh """
            aws lambda invoke \
              --function-name lambda \
              --region ap-south-1 \
              --payload {
                 "subnet_id":"${SUBNET_ID}",
                 "name":"Yasin",
                 "email":"sutaryasin243@gmail.com"} \
              output.json
          """
          output = readFile('output.json')
        }
        script {
          if (output.contains('"statusCode": 200')) {
            echo 'Lambda function invocation was successful'
          } else {
            echo 'Lambda function invocation failed'
          }
        }
      }
      
      
     
 
  }
  
}
}
