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
stage('Configure AWS') {
            steps {
                sh 'aws configure set aws_access_key_id AKIARN47KMZ7CBDA7FOU'
                sh 'aws configure set aws_secret_access_key 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'
                sh 'aws configure set default.region ap-south-1'
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
            aws lambda invoke --function-name lambda_handler --region ap-south-1 --cli-binary-format raw-in-base64-out  --payload  '{ "subnet_id":"${SUBNET_ID}" }' response.json  --log-type Tail
          """
          output = readFile('response.json')
          
        }
        
      }
      
      
     
 
  }
  
}
}
