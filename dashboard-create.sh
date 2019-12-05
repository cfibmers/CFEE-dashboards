#!/bin/bash

sysdig_region=$1

if [ "$#" -ne 2 ]; then
	echo "Required arguments missing!"
	echo "Usage : ./dashboard-create.sh <sysdig_region> <sysdig_api_token>"
	echo "<sysdig_region> value is one of us-south, eu-de,eu-gb,jp-tok,us-east,au-syd"
	echo "<sysdig_api_token> is the API token to authenticate with the IBM Cloud Monitoring with Sysdig service"
	exit 1
fi

sysdig_api_token=$2

sysdigEndpoint="https://$1.monitoring.cloud.ibm.com/api/v2/dashboards"
iamEndpoint="https://iam.cloud.ibm.com"

# Don't run if any of the prerequisites are not installed.
prerequisites=("curl")
for i in "${prerequisites[@]}"; do
	isExist=$(command -v $i)
	if [ -z "$isExist" ]; then
		echo "$i not installed. Please install the required pre-requisites $i first"
		exit 1
	fi
done

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d @CFEESum.json)
echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Dashboard created successfully!"
else
	exit 1
fi

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d @CFEECell.json)
echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Dashboard created successfully!"
else
	exit 1
fi
status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d @CFEEDiego.json)
echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Dashboard created successfully!"
else
	exit 1
fi
status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d @CFEERouter.json)
echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Dashboard created successfully!"
else
	exit 1
fi



echo "All CFEE Dashboards created successfully!"
