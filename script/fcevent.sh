# Send event report to Farmcentral server
#
# Usage: fcevent single_access_token event_code
#
# The single_access_token is returned from the previous fclogin command
#
if [ $# -ne 2 ]
then
	echo "Usage: fcevent single_access_token event_code"
	exit 1
fi

curl  -H "Content-Type: application/json"  -X POST -d "{\"location_id\":9, \"event_code\": ${2} }" http://farmcentral.softimum.com:3000/event_reports.json?user_credentials=${1}
