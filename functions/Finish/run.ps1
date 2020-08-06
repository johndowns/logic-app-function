using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host 'Triggered Finish function.'

# Simulate doing some work that might be done to finish the workflow.
Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 3)

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
})
