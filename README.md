# CloudUploader-CLI-Project

This project aims to simplify uploads to Azure cloud storage through a custom Bash-based CLI tool. The objective is to have give users the ability to securely and efficiently upload files from their local environment to designated Azure storage accounts and containers. This tool streamlines the process, and attempts to make it easy for users to upload files to Azure cloud storage.

## Overview

- Simplified Azure authentication.
- Bulk file upload to your Azure Blob Storage container.
- Creation of shareable links for uploaded files.
- Effortless installation procedure.

## Prerequisites

- Ensure the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) is installed and configured on your machine.
- Possess an active Azure subscription, along with permissions to create and manage Azure Blob Storage resources.
- Have access to a Bash environment, which can be found on Linux/Unix, macOS, and Windows Subsystem for Linux (WSL) and [VScode](https://code.visualstudio.com/Download).

To install Azure CLI in 😮Visual Studio Code, follow these steps:
1. Open Visual Studio Code.
2. From the View menu, select Extensions.
3. In the search field, enter "Azure Developer CLI" and select [Install](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/debug).
4. Alternatively, you can install the [Azure Account extension](https://www.howtogeek.com/devops/how-to-access-azure-cloud-shell-from-visual-studio-code/) from the Extensions icon on the left-hand menu.
5. If you prefer using PowerShell, run the following code: [How to Use VS Code for Azure CLI - AzureTracks](https://azuretracks.com/2019/12/how-to-use-vs-code-for-azure-cli/)


# Setting Up the Container and Preparing the Environment for the Tool🚀
1. After installing the Azure CLI, use the `az login` command to authenticate to the cloud. This step is necessary to create a storage account. Once logged in, create a resource group; I named mine cloud-uploader-CLI, but you can choose any name you prefer.
Once the resource group is created, proceed to set up the storage account that will house our LRS (Locally Redundant Storage) Blob with the following command:
```bash
az storage account create --name (storage-account-name-here) --resource-group (resource-group-name-here) --location eastus --sku Standard_LRS --kind StorageV2 --allow-blob-public-access false
```
Next, create the container for uploading blobs (files) using:
```bash
az storage container create --name (container-name-here) --account-name (storage-account) --auth-mode login
```
2. To test our script, it's essential to set the environment variables in the BASH terminal, authorizing access to Blob storage via the Azure CLI. Instead of using the parameters account-name and account-key, it's more convenient to set the environment variables AZURE_STORAGE_ACCOUNT and AZURE_STORAGE_KEY. This way, there's no need to provide this information with every `az storage` command. First, discover your key with the command:
```bash
az storage account keys list --account-name (acc-name-here) --resource-group (resource-group-name-here) --output Table
```
This command will display the account keys, which you can then use to set the environment variables with the "export" command in bash:
```bash
export AZURE_STORAGE_ACCOUNT="acc name here" ; export AZURE_STORAGE_KEY="key goes here"
```

## Installations

1. Clone the Repo using:
```bash
git clone https://github.com/Pusha876/azure-Cloud-Uploader-CLI
```
2. Change directory to where the tool is being used:
```bash
cd azure-cloud-uploader-CLI
```
3. Grant yourself permissions for the azure_uploader.sh script to start using it.
```bash
chmod +x azure_uploader.sh
./azure_uploader.sh
```
* After installation, the azure_uploader script command will be available globally in your terminal.

## Usage

To upload a single file to Azure Blob Storage, execute the command below:

```bash
./azure_uploader.sh /path/to/file
```

For uploading multiple files to Azure Blob Storage, use the command:

```bash
./azure_uploader.sh /path/to/file1 /path/to/file2 ...
```

The following is a demonstration of the tool's capabilities:

![alt text](<azure_uploader_cli/images/uploader successful.png>)

## Troubleshooting Tips😵‍💫

- **Authentication Issues**:
   - Confirm that your Azure CLI is logged in with `az login` and possesses the required permissions.
- **Upload Failures**:
   - Verify the accuracy of the specified file path and your write permissions for the Azure Blob Storage container.
- **Link Generation Errors**:
   - Check that your storage account name and container name are correctly set up in the script.
- **File Not Found Errors**:
- To handle file paths correctly in the script, you need to ensure that the paths are properly managed and that any relative paths are converted to absolute paths. The following script includes relative paths and providing more informative error messages.

```bash
# Convert the file path to an absolute path
FILE_PATH=$(realpath "$FILE_PATH")

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File not found at path: $FILE_PATH"
    exit 1
fi
```
**Debugging Bash Script**
```bash
# Debug: Print initial file path
echo "Initial file path: $FILE_PATH"

# Debug: Print absolute file path
echo "Absolute file path: $FILE_PATH"

```
**Debugging Output**

The script will output the initial and absolute file paths. If the absolute file path does not correspond to a valid file, there might be an issue with how the path is specified or the **'realpath'** command is executed.

1. **Check File Existence Manually**: Ensure the file exists at the specified path by using the ls command:
```bash
ls -l /path/to/your/file
```
2. **Ensure Correct Path**: Ensure the path provided to the script is correct and the file exists.

1. **Realpath Command**: Verify the **'realpath'** command works as expected:

```bash
realpath /path/to/your/file
```
If `realpath` is not available on your system, you can use an alternative method to get the absolute path.

By adding these debugging steps, you should be able to identify and fix the issue with the file path.!![alt text](azure_uploader_cli/images/image.png)