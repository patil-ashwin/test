
#!/bin/bash

# Define the API endpoint
API_URL="https://api.example.com/endpoint"

# Make the POST request and capture the response body and status code
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL")

# Extract the response body
HTTP_BODY=$(echo "$RESPONSE" | head -n -1)

# Extract the HTTP status code
HTTP_STATUS=$(echo "$RESPONSE" | tail -n 1)

# Check if the HTTP status code is in the 2xx range
if [[ $HTTP_STATUS =~ ^2[0-9][0-9]$ ]]; then
    echo "Success! HTTP status code: $HTTP_STATUS"
    echo "Response body: $HTTP_BODY"
    exit 0
else
    echo "Error! HTTP status code: $HTTP_STATUS"
    echo "Response body: $HTTP_BODY"
    exit 1
fi
