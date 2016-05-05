[#ftl]
[#assign pollingperiod = topology.pollingperiod]
#!/bin/sh
[#if symapi.path??]
export PATH=$PATH:${symapi.path}
[#else]
export PATH=$PATH:/opt/emc/SYMCLI/bin
[/#if]
[#if symapi.connect_type == 'remote']
export SYMCLI_CONNECT=${symapi.connect}
[/#if]
export SYMCLI_CONNECT_TYPE=${symapi.connect_type}

#Get the Date in epoch value
endDate=`date +%s`
#echo "End Date value   : $endDate"
# - 300 seconds that is 5 minute from the value
#startDate=$(($endDate - 30000 ))
# - 14990400 seconds is approximately 173.5 days from the value
startDate=$(($endDate - ${pollingperiod} ))
#echo "Start Date value : $startDate"
#Convert the vlaues to required Date formatt +%m/%d/%y:%H:%M:%S
endStr=`date -d@$endDate +%m/%d/%y:%H:%M:%S`
startStr=`date -d@$startDate +%m/%d/%y:%H:%M:%S`
#echo "Start date String => $startStr"
#echo "End date String ===> $endStr"

#Run the command with arguments
$* "-start" $startStr "-end" $endStr




