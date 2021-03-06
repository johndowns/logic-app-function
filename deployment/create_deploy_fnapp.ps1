param(
     [Parameter(Mandatory=$True)]
     [string]
     $ResourceGroup,

     [Parameter(Mandatory=$True)]
     [string]
     $StorageAccountName,

     [Parameter(Mandatory=$True)]
     [string]
     $Location,

     [Parameter(Mandatory=$True)]
     [string]
     $FnAppName
)

Write-Host "Sign in to Azure interactively"
Connect-AzAccount

Write-Host "Create storage account for Azure Function"
New-AzStorageAccount -ResourceGroupName $ResourceGroup `
                          -AccountName $StorageAccountName `
                          -Location $Location `
                          -SkuName Standard_GRS

Write-Host "Create Azure Function (Consumption) with PowerShell runtime"
New-AzFunctionApp -Name  $FnAppName `
                         -ResourceGroupName $ResourceGroup `
                         -Location $Location `
                         -StorageAccount $StorageAccountName `
                         -Runtime PowerShell `
                         -FunctionsVersion 3 `
                         -OSType Windows `
                         -RuntimeVersion 6.2

Write-Host "Waiting for 20 seconds for function app to complete deployment"
Start-Sleep -Seconds 20

Write-Host "Deploy function to Azure"
Set-Location -Path (Join-Path $PSScriptRoot '..' 'functions')
func azure functionapp publish $FnAppName --powershell
