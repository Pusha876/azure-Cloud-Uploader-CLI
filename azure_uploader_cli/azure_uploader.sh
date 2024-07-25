# azure_uploader.sh
#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 uploaderclistorage321 uploader https://uploaderclistorage321.blob.core.windows.net/uploader"
    exit 1
fi

STORAGE_ACCOUNT=$1
CONTAINER_NAME=$2
FILE_PATH=$3

# Debug: Print initial file path
echo "Initial file path: $FILE_PATH"

# Convert the file path to an absolute path
FILE_PATH=$(realpath "$FILE_PATH")

# Debug: Print absolute file path
echo "Absolute file path: $FILE_PATH"

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File not found at path: $FILE_PATH"
    exit 1
fi

# Get the storage account key
ACCOUNT_KEY=$(az storage account keys list --account-name $STORAGE_ACCOUNT --query "[0].value" --output tsv)

if [ -z "$ACCOUNT_KEY" ]; then
    echo "Failed to retrieve the account key for storage account: $STORAGE_ACCOUNT"
    exit 1
fi

# Create the container if it does not exist
az storage container create \
    --account-name $STORAGE_ACCOUNT \
    --account-key $ACCOUNT_KEY \
    --name $CONTAINER_NAME \
    --output none


# Upload the file to the specified container
az storage blob upload \
    --account-name $STORAGE_ACCOUNT \
    --account-key $ACCOUNT_KEY \
    --container-name $CONTAINER_NAME \
    --name $(basename $FILE_PATH) \
    --file $FILE_PATH

if [ $? -eq 0 ]; then
    echo "File uploaded successfully to container: $CONTAINER_NAME"
else
    echo "File upload failed"
    exit 1
fi
