# Log in as a controller to the Farmcentral server
#
# Returns a JSON response with a single access token
#
curl  -H "Content-Type: application/json"  -X POST -d '{"username":"west_barn","password":"oakgrove"}' http://farmcentral.softimum.com:3000/user_sessions.json
