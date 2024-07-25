# install.sh
#!/bin/bash

# Define the installation path
INSTALL_PATH="/usr/local/bin"

# Copy the script to the installation path
cp azure_uploader.sh "$INSTALL_PATH/azure-upload"

# Make the script executable
chmod +x "$INSTALL_PATH/azure-upload"

echo "Installation complete. You can now use the 'azure-upload' command."
