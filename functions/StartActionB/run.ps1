using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host 'Triggered Start Action B function.'

# Simulate doing some work that might be done to start Action B as a long-running process (e.g. calling another API).
Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 3)

# Create a random operation ID to simulate what a long-running process might do.
$operationId = New-Guid

# Create the body of the response.
$body = "{""operationId"": ""$operationId""}"

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::Accepted
    ContentType = "application/json"
    Body = $body
    Headers = @{
        Location = "https://$env:WEBSITE_HOSTNAME/api/GetActionBStatus?operationId=$operationId"
    }
})
