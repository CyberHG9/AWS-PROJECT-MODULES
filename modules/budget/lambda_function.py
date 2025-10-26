import json
import boto3
import os

def lambda_handler(event, context):
    print("🔔 Budget alert received:")
    print(json.dumps(event))

    # Extraemos los datos del evento 
    try:
        sns_message = event['Records'][0]['Sns']['Message']
        message_data = json.loads(sns_message)
    except Exception:
        message_data = {"raw_message": sns_message}

    # Creamos el contenido del correon 
    subject = "AWS Budget Alert: Limit Exceeded"
    body = f"""
    Hello from AWS Lambda,

    Your budget alert has been triggered with the following details:

    Budget Name: {message_data.get('budgetName', 'Unknown')}
    Alert Type: {message_data.get('notificationType', 'N/A')}
    Threshold: {message_data.get('threshold', 'N/A')}%
    Current Spend: {message_data.get('costAmount', 'N/A')} {message_data.get('costUnit', '')}
    Limit: {message_data.get('budgetLimitAmount', 'N/A')} {message_data.get('budgetLimitUnit', '')}

    Please review your resources in the AWS Console.
    """

    # Enviar correo via SES
    ses = boto3.client('ses')
    response = ses.send_email(
        Source=os.environ['FROM_EMAIL'],
        Destination={'ToAddresses': [os.environ['TO_EMAIL']]},
        Message={
            'Subject': {'Data': subject},
            'Body': {'Text': {'Data': body}}
        }
    )

    print("📧 Email sent successfully:", response)
    return {"statusCode": 200, "body": "Alert processed and email sent."}
