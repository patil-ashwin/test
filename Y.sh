#!/bin/bash

# Define the API endpoint
API_URL="https://api.example.com/endpoint"

# Make the POST request and capture the response status code
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$API_URL")

# Check if the HTTP status code is in the 2xx range
if [[ $HTTP_STATUS =~ ^2[0-9][0-9]$ ]]; then
    echo "Success! HTTP status code: $HTTP_STATUS"
    exit 0
else
    echo "Error! HTTP status code: $HTTP_STATUS"
    exit 1
fi
