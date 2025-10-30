import json
import os
import boto3
import urllib.request

FROM_EMAIL = os.environ['FROM_EMAIL']
TO_EMAIL = os.environ['TO_EMAIL']
SLACK_WEBHOOK_URL = os.environ['SLACK_WEBHOOK_URL']
SLACK_CHANNEL = os.environ.get('SLACK_CHANNEL', '#alerts')

ses = boto3.client('ses')

def send_email(subject, message):
    ses.send_email(
        Source=FROM_EMAIL,
        Destination={'ToAddresses': [TO_EMAIL]},
        Message={
            'Subject': {'Data': subject},
            'Body': {'Text': {'Data': message}}
        }
    )

def send_slack_message(subject, message):
    payload = {
        "channel": SLACK_CHANNEL,
        "text": f":warning: *{subject}*\n{message}"
    }
    data = json.dumps(payload).encode('utf-8')
    req = urllib.request.Request(
        SLACK_WEBHOOK_URL,
        data=data,
        headers={'Content-Type': 'application/json'}
    )
    urllib.request.urlopen(req)

def lambda_handler(event, context):
    print("Event received:", event)
    
    subject = "AWS Budget Alert Triggered"
    message = json.dumps(event, indent=2)
    
    # Send both notifications
    send_email(subject, message)
    send_slack_message(subject, message)
    
    return {'statusCode': 200, 'body': 'Notifications sent'}
