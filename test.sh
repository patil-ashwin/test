#!/bin/bash

#######################################################################################################
# Script Name: rest_api_post.sh
# Description: A shell script to make a POST request to a REST API with optional authorization token
#              and payload. The script throws an error if the API response code is not 2xx.
# Author: [Your Name]
# Date: [Date]
#######################################################################################################

# Set variables for the API endpoint, authorization token, and request payload
API_URL="https://api.example.com/endpoint"
AUTH_TOKEN=""  # Set your authorization token here, leave empty if not required
PAYLOAD=""      # Set your payload data here, leave empty if not required

# Function to make the API call
make_api_call() {
    ###################################################################################################
    # Function Name: make_api_call
    # Description: Makes a POST request to the specified API endpoint with optional authorization token
    #              and payload. Throws an error if the response code is not 2xx.
    # Arguments: None
    ###################################################################################################
    
    # Make the API call using curl
    local response=$(curl -s -X POST -H "Content-Type: application/json" \
                    $( [ -n "$AUTH_TOKEN" ] && echo "-H 'Authorization: Bearer $AUTH_TOKEN'" ) \
                    $( [ -n "$PAYLOAD" ] && echo "-d '$PAYLOAD'" ) \
                    "$API_URL")

    # Extract the HTTP response code from the response
    local response_code=$(echo "$response" | head -n 1 | awk '{print $2}')

    # Check if response code is 2xx
    if [[ $response_code =~ ^2 ]]; then
        echo "API call successful"
        echo "Response: $response"
    else
        echo "API call failed with response code $response_code"
        echo "Response: $response"
        exit 1
    fi
}

# Call the function to make the API call
make_api_call
