pipeline {
  agent any
   environment {
    SUBNET_ID = sh(returnStdout: true, script: 'terraform output -raw subnet_id').trim()
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


   
      


    stage('Plan') {
      steps {
        sh 'terraform plan'
      }
    }
   
    stage('Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }

    /*
    stage('Destroy') {
      steps {
        sh 'terraform destroy -auto-approve'
      }
    }
       
    */

    stage('Invoke Lambda Function') {
      
      steps {
        script {
          sh """
            aws lambda invoke \
              --function-name lambda_handler \
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
