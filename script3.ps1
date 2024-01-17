# Import the Active Directory module
Import-Module ActiveDirectory

# Function to add a user to Active Directory
function Add-ADUserAndLog {
    param (
        [string]$username,
        [string]$password,
        [string]$firstname,
        [string]$lastname,
        [string]$ou # Organizational Unit
    )

    # Add the user to Active Directory
    New-ADUser -SamAccountName $username -UserPrincipalName "$username@yourdomain.com" -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -Enabled $true -AccountPassword (ConvertTo-SecureString -AsPlainText $password -Force) -Path $ou

    # Log information to Excel
    $logData = [PSCustomObject]@{
        'Action'       = 'User Added'
        'Username'     = $username
        'DateCreated'  = (Get-Date)
    }

    $logData | Export-Csv -Path 'C:\Path\To\Your\Log\File.csv' -Append -NoTypeInformation
}

# Function to remove a user from Active Directory
function Remove-ADUserAndLog {
    param (
        [string]$username
    )

    # Get the user before removing
    $user = Get-ADUser -Filter {SamAccountName -eq $username}

    # Remove the user from Active Directory
    Remove-ADUser -Identity $user.DistinguishedName -Confirm:$false

    # Log information to Excel
    $logData = [PSCustomObject]@{
        'Action'       = 'User Removed'
        'Username'     = $username
        'DateRemoved'  = (Get-Date)
    }

    $logData | Export-Csv -Path 'C:\Path\To\Your\Log\File.csv' -Append -NoTypeInformation
}

# Example usage:
# Add a user
Add-ADUserAndLog -username 'NewUser' -password 'Password123' -firstname 'John' -lastname 'Doe' -ou 'OU=Users,DC=yourdomain,DC=com'

# Remove a user
Remove-ADUserAndLog -username 'ExistingUser'

