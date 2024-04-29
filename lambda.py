def lambda_handler(event, context):
    # This is a sample Lambda function
    print("Received event: " + str(event))
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda!'
    }
