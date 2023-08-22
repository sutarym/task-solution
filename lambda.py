
import os
import json
import boto3
import base64
import requests

def lambda_handler(event, context):

  request_body_ = {
    'subnet_id': event['subnet_id'],
    'name': "Yasin",
    'email': "sutaryasin243@gmail.com"
  }

  request_body = json.dumps(request_body_)
 













  request_headers = {
        'X-Siemens-Auth': 'test'
        "Content-Type": "application/json"
        
    }

  response = request.post('https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data',
                             headers=request_headers,
                             data=json.dumps(request_body))
  
  convertbytes = response.encode("ascii")
  convertedbytes = base64.b64decode(convertbytes)
  decodedsample = convertedbytes.decode("ascii")
  print(f"The string after decoding is: {decodedsample}")
  f = open('base64_out.txt', 'w')
  f.write(decodedsample)
  f.close()
 
  if response.status_code == 200:
    return {
      'statusCode': 200,
      'body': json.dumps({'message': 'The request was successful.'})
    }
  else:
    return {
      'statusCode': response.status_code,
      'body': json.dumps({'message': 'The request failed.'})
    }


