#!/bin/bash

sysdig_region=$1

if [ "$#" -ne 2 ]; then
	echo "Required arguments missing!"
	echo "Usage : ./alert-create.sh <sysdig_region> <sysdig_api_token>"
	echo "<sysdig_region> value is one of us-south, eu-de,eu-gb,jp-tok,us-east,au-syd"
	echo "<sysdig_api_token> is the API token to authenticate with the IBM Cloud Monitoring with Sysdig service"
	exit 1
fi

sysdig_api_token=$2

sysdigEndpoint="https://$1.monitoring.cloud.ibm.com/api/alerts"
iamEndpoint="https://iam.cloud.ibm.com"

# Don't run if any of the prerequisites are not installed.
prerequisites=("curl")
for i in "${prerequisites[@]}"; do
	isExist=$(command -v $i)
	if [ -z "$isExist" ]; then
		echo "$i not installed. Please install the required pre-requisites curl first"
		exit 1
	fi
done

#HighNumberOfRejectedRequests

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighNumberOfRejectedRequests > 1 per sec","description": "Gorouters received too many rejected requests.","enabled": false,"severity": 4,"timespan": 300000000, "condition": "avg(timeAvg(firehose_counter_event_gorouter_rejected_requests_total))> 1","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighNumberOfRejectedRequests > 5 per sec","description": "Gorouters received too many rejected requests.","enabled": false,"severity": 1,"timespan": 300000000, "condition": "avg(timeAvg(firehose_counter_event_gorouter_rejected_requests_total))> 5","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:HighNumberOfBadGateways

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighNumberOfBadGateways> 1 per sec","description": "Gorouters received too many bad gateway requests.","enabled": false,"severity": 4,"timespan": 300000000, "condition": "avg(timeAvg(firehose_counter_event_gorouter_bad_gateways_total))> 1","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighNumberOfBadGateways> 5 per sec","description": "Gorouters received too many bad gateway requests.","enabled": false,"severity": 1,"timespan": 300000000, "condition": "avg(timeAvg(firehose_counter_event_gorouter_bad_gateways_total))> 5","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:GorouterHighNumber4xx

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]GorouterHighNumber4xx","description": "High number of 4xx HTTP responses on Gorouter.","enabled": false,"severity": 4,"timespan": 300000000, "condition": "avg(timeAvg(firehose_counter_event_gorouter_responses_4_xx_delta))> 0.2","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:GorouterHighNumber5xx

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]GorouterHighNumber5xx","description": "High number of 5xx HTTP responses on Gorouter.","enabled": false,"severity": 4,"timespan": 300000000, "condition": "avg(timeAvg(firehose_counter_event_gorouter_responses_5_xx_delta))> 0.2","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:UnhealthyCell

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]UnhealthyCell","description": "Unhealthy cell found.","enabled": false,"severity": 4,"timespan": 60000000, "condition": "max(avg(firehose_value_metric_rep_unhealthy_cell))> 1","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:DiegoApiActivePassiveWrong

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]DiegoApiActivePassiveWrong","description": "One of diego-api pods is in wrong active passive status.","enabled": false,"severity": 1,"timespan": 60000000, "condition": "sum(sum(firehose_value_metric_bbs_lock_held)) != 1","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:HighMemoryUsageForCells > 80%

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighMemoryUsageForCells > 80%","description": "High memory usage for cells to allocate to containers.","enabled": false,"severity": 4,"timespan": 60000000, "condition": "sum(sum(firehose_value_metric_rep_capacity_remaining_memory))< 5","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:HighMemoryUsageForCells > 95%

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighMemoryUsageForCells > 95%","description": "High memory usage for cells to allocate to containers.","enabled": false,"severity": 1,"timespan": 300000000, "condition": "sum(sum(firehose_value_metric_rep_capacity_remaining_memory))< 2","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:HighDiskUsageForCells > 80%

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighDiskUsageForCells> 80%","description": "High disk usage for cells to allocate to containers.","enabled": false,"severity": 4,"timespan": 60000000, "condition": "sum(sum(firehose_value_metric_rep_capacity_remaining_disk))< 20","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:HighDiskUsageForCells > 95%

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighDiskUsageForCells> 95%","description": "High disk usage for cells to allocate to containers.","enabled": false,"severity": 1,"timespan": 300000000, "condition": "sum(sum(firehose_value_metric_rep_capacity_remaining_disk))< 10","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:HighContainersUsageForCells> 80%

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighContainersUsageForCells> 80%","description": "High containers usage for cells to allocate to containers.","enabled": false,"severity": 4,"timespan": 60000000, "condition": "sum(sum(firehose_value_metric_rep_capacity_remaining_containers))< 50","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

#CF:HighContainersUsageForCells> 95%

status=$(curl -X POST $sysdigEndpoint -H "Authorization: Bearer $sysdig_api_token" -H 'Content-Type: application/json' -d \
'{"alert": {"type": "MANUAL", "name": "[CFEE]HighContainersUsageForCells> 95%","description": "High containers usage for cells to allocate to containers.","enabled": false,"severity": 1,"timespan": 300000000, "condition": "sum(sum(firehose_value_metric_rep_capacity_remaining_containers))< 20","filter": ""}}')

echo $status
if [[ "$status" =~ "createdOn" ]]; then
	echo "Alert created successfully!"
else
	exit 1
fi

echo "All alerts created successfully!"
