using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host 'Triggered Get Action B Status function.'

# Verify an operation ID was passed in by the caller.
$operationId = $Request.Query.operationId
if (!$operationId)
{
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::BadRequest
        ContentType = "application/json"
        Body = '{"error": "Please provide an operation ID."}'
    })
    return
}

# Simulate doing some work to get the operation status.
Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 3)

# Get a random number between 1 and 10. If the number is less than 3, we will say the operation is complete.
$randomValue = Get-Random -Minimum 1 -Maximum 10
if ($randomValue -lt 3)
{
    # Simulate the operation being completed.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
    })
}
else
{
    # Simulate the operation still being underway.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::Accepted
        ContentType = "application/json"
        Body = $body
        Headers = @{
            Location = "https://$env:WEBSITE_HOSTNAME/api/GetActionBStatus?operationId=$operationId"
        }
    })
}

