# Send status report to Farmcentral server
#
# Usage: fcss single_access_token
#
# The single_access_token is returned from the previous fclogin command
#
curl  -H "Content-Type: application/json"  -X POST -d '{"location_id":9, "humidity":66, "air_quality":"OK",
 "system_status":"OK", "temperatures_attributes":[{"value":22}, {"value":24}, {"value":25}],
 "AC_power":"OK", "CO":"OK", "water_total":1000, "propane_total":998, 
 "ir_feeds_attributes":[{"status":"OK"}, {"status":"OK"}], 
 "curtain_states_attributes":[{"status":"Open"}, {"status":"Partial"}],
 "brooder_heater_states_attributes":[{"status":"On"}, {"status":"On"}, {"status":"Off"}],
 "vent_fans_attributes":[{"value":40}, {"value":10}, {"value":50}]
}' http://farmcentral.softimum.com:3000/readings.json?user_credentials=${1}
