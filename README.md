

# Intro

IBM Cloud Monitoring with Sysdig is powered by Sysdig in partnership with IBM, which is proposed monitoring solution for IBM IKS and CFEE. Follow the steps below to create CFEE operation dashboard and Alerts in Sysdig.

## CFEE releases
###  CFEE release 5.0
This release is compatible with below dashobards which can be further consumed by Sysdig.
1. CFEEDiego.json
2. CFEERouter.json
3. CFEECell.json

### CFEE release 6.0
In this release we have CFEE with eirini plan implemented. Dashboard `CFEERouter.json` is the common dashboard works all CFEE plans. `CFEECell.json` and `CFEEDiego.json` will work with CFEE without eiriniplan only.

We have added new dashboards for `cfapitester` component. They are the common dashboards applicable for CFEE on Eirini and non-Eirini clusters
1. CFEE-cfapitester-internal-metrics.json
2. CFEE-cfapitester-push-test.json
3. CFEE-cfapitester-runtimes.json
They are only valid on current CFEE release 6.0

# Prerequisites

- Follow this link to get Sysdig [API Token](https://cloud.ibm.com/docs/services/Monitoring-with-Sysdig?topic=Sysdig-api_token)
- Follow this link to check your Sysdig instance region and endpoint. [End Point](https://cloud.ibm.com/docs/services/Monitoring-with-Sysdig?topic=Sysdig-endpoints)

# Steps to create the dashboards
Use the shell script dashboard-create.sh in this repository to create the dashboards.

`Usage :`

`./dashboard-create.sh <sysdig_region> <sysdig_api_token>`

`<sysdig_region> value is one of us-south, eu-de,eu-gb,jp-tok,us-east,au-syd`

`<sysdig_api_token> is the API token to authenticate with the IBM Cloud Monitoring with Sysdig service`


# Steps to create the Alerts
Use the shell script alert-create.sh in this repository to create the Alerts.

`Usage :`

`./alert-create.sh <sysdig_region> <sysdig_api_token>`

`<sysdig_region> value is one of us-south, eu-de,eu-gb,jp-tok,us-east,au-syd`

`<sysdig_api_token> is the API token to authenticate with the IBM Cloud Monitoring with Sysdig service`

# Troubleshooting

## Create dashboard from json file in this repository,

curl -X POST https://us-south.monitoring.cloud.ibm.com/api/v2/dashboards -H 'Authorization: Bearer <sysdig_api_token>' -H 'Content-Type: application/json' -d @ json file

## Deleting the dashboard

curl -X DELETE https://us-south.monitoring.cloud.ibm.com/api/v2/dashboards/ID -H 'Authorization: Bearer <sysdig_api_token>' -H 'Content-Type: application/json'


## Save all dashboards:

curl -X GET https://us-south.monitoring.cloud.ibm.com/api/v2/dashboards -H 'Authorization: Bearer <sysdig_api_token>' -H 'Content-Type: application/json' >> json file

## Save single dashboard:

curl -X GET https://us-south.monitoring.cloud.ibm.com/api/v2/dashboards/ID -H 'Authorization: Bearer <sysdig_api_token>' -H 'Content-Type: application/json' >> json file

## Update existing dashboard:

  curl -X PUT https://us-south.monitoring.cloud.ibm.com/api/v2/dashboards/ID -H 'Authorization: Bearer <sysdig_api_token>' -H 'Content-Type: application/json' -d @ json file
  
## Get the complete list of existing alerts

curl -X GET -H "Authorization: Bearer " -H "Accept: application/json" https://eu-de.monitoring.cloud.ibm.com/api/alerts

## Get an alert

curl -X GET -H "Authorization: Bearer " -H "Accept: application/json" -H "Content-Type: application/json;charset=UTF-8" https://eu-de.monitoring.cloud.ibm.com/api/alerts/ID

## Delete an alert

curl -v -X DELETE -H "Authorization: Bearer " https://eu-de.monitoring.cloud.ibm.com/api/alerts/ID
