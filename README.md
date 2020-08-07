# Logic Apps and PowerShell functions: Workflow example

This sample illustrates how a logic app and a set of Azure Functions (written in PowerShell) can be used to orchestrate a workflow of PowerShell scripts.

The sample includes examples of:
* Running a scheduler (using a logic app recurrence trigger).
* Triggering PowerShell functions from a logic app.
* Fan-out of multiple functions running in parallel, and fan-in once they are complete.
* Orchestrating an asynchronous API flow using the [built-in Logic Apps support for asynchronous HTTP APIs](https://docs.microsoft.com/azure/logic-apps/logic-apps-create-api-app#perform-long-running-tasks-with-the-polling-action-pattern).

In future, it will also be possible to use durable functions to achieve this, but as of the time of writing (August 2020) the durable functions SDK support for PowerShell is still considered to be an experimental preview.

IMPORTANT NOTE: We are using anonymous authentication on the functions for simplicity. In a real function app, you should authenticate using the [function API key](https://docs.microsoft.com/azure/azure-functions/functions-bindings-http-webhook-trigger?tabs=csharp#api-key-authorization) or another [production-ready security feature](https://docs.microsoft.com/azure/azure-functions/functions-bindings-http-webhook-trigger?tabs=csharp#secure-an-http-endpoint-in-production).

## How to run this sample

### Deploy function app

1. Install the [Azure Functions core tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local) if you do not already have them installed.
2. Run the `deployment/create_deploy_fnapp.ps1` script from this repository.

### Deploy logic app

1. Create a new logic app.
2. Open the logic app's code view.
3. Paste the contents of the `logic-app/Orchestrator.json` file from this repository.
4. Within the code view, replace the `REPLACEME` pieces with the name of your function app.
5. Save the logic app.
