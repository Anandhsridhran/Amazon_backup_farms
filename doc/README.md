# Farm Central Web Application

#### Table of Contents

[Introduction](#introduction)

[User Roles](#users)

[API Specification](#api_spec)

[Authentication](#authentication)

[Farms, Locations and Barns](#farms_locations)

[Current readings](#readings)

[Events](#events)

[Shipments](#shipments)

[Inventory](#inventory)

[Configuration settings](#configuration)

[Database schema](#schema)

<a name="introduction"/>
## Introduction

This document describes the Web service API provided by the Farm Central Web application. 
This application runs on both the AMF Nano cloud server and on each SBC (single board computer) at each barn.
This Web service is used by the Farm Central mobile apps running on IOS (iPhones / iPads) and Androids to
display environmental conditions and track inventory at farms. 

This API is also used by the SBC controller process to report environmental readings and alarm events to the
cloud server and to fetch configuration and threshold information from the server.

<a name="users"/>
## User roles

Each user in the system has a single *role*.  These roles are defined below.

| Role        | Description                                             |
|-------------|---------------------------------------------------------|
| FarmOwner   | Owns a single farm. A farm can have several locations.  |
| HogOwner    | Supplies pigs to several farms.                  |
| SiteManager | Manages a single location within a farm. A location can have several barns. |
| BarnManager | Manages a single barn.         |
| ControllerAdmin | Acts as the user assigned to the SBC controller in the barn. | 
| Admin       | Superuser who can set up all users and farms  |

The role determines which farms, locations or barns the user is allowed to access, as 
shown below.

| Role        | Access permissions                                             |
|-------------|----------------------------------------------------------|
| FarmOwner   | Can view and update the single farm he owns, plus all its locations and barns.  |
| HogOwner    | Can view and update all the farms, locations and barns he supplies pigs to. |
| SiteManager | Can view and update the location he manages, and the barns in that location. |
| BarnManager | Can view and update the barn he manages.         |
| ControllerAdmin | Can view and update the barn where the controller resides.  | 
| Admin       | Can create, view and update all farms, locations, barns and users | 

<a name="api_spec"/>
## API Specification

The Web service is based on the REST approach, where URLs are named after the objects of interest, and there is a 
standard format for obtaining and updating information using JSON. In the following curl commands, *base_uri* will change 
depending on development versus production. For development, use _farmcentral.softimum.com:3000_ for the base_uri. 

<a name="authentication"/>
### Login and authentication

All HTTP requests to the cloud server are secured by requiring a special 20-character _single access token_ to be 
appended to the end of each request. Any request that does not have this token is rejected. To obtain this token, 
the external app must first login using the username and password of an authorized Farm Central user.  

The mobile apps can login using the credentials of a Hog Owner, Farm Owner, Site Manager or Barn Manager.
The controller inside the barn can login using the ControllerAdmin user account which was created for that barn. 
 

#### Login Request

To login, the controller must send the equivalent of the following curl command:

    curl  -H "Content-Type: application/json"  -X POST -d '{"username":"jdavidson","password":"SomePassword"}' 
    http://<base_uri>/user_sessions.json
    

#### Response

Upon successful authentication, a JSON response in the following format is sent back to the controller application:

```
{
  "user_id":7,
  "single_access_token":"1a3ZTHjWWgpJ5DmoCRti",
  "first_name":"John",
  "last_name":"Davidson",
  "role":"FarmOwner",
  "email":"jdavidson@gmail.com",
  "username":"jdavidson",
  "barn_id":0,
  "location_id":0,
  "farm_id":1
}
```

This message contains the unique **user_id** of the user and the **single_access_token** that must be appended to 
future messages. It also has the user's role. 

If the role is **FarmOwner**, the response contains the **farm_id** of the farm he owns. 
If the role is **SiteManager**, the response contains the **location_id** of the location he manages,
along with the farm_id of the location's farm. 
If the role is **BarnManager** or **ControllerAdmin**, the response contains the **barn_id** of the
associated barn. It also contains the barn's location_id and farm_id. 

If the authentication fails, the cloud server will respond with a standard 401 HTTP error message. 

<a name="farms_locations">
### Farms, Locations and Barns

The mobile app can query the cloud server for which barns belong to a particular location, which locations
belong to a particular farm, and which farms are supplied by a particular Hog Owner. These queries
are described in this section. 

#### Farms supplied by a Hog Owner

When a Hog Owner logs in, the app will need to know which farms he supplies, so that it can present a
list of farms to choose from. This can be done by sending the following GET message:

```
wget http://<base_uri>/users/<user_id>/farms.json?user_credentials=<single_access_token>
```

The **user_id** above is the Hog Owner's user_id as provided in the response to the Login message. 
The cloud server will then respond with the list of farms supplied by the Hog Owner, as follows:

```
[
  { 
    "farm_id":1, 
    "name":"Oak Grove Farm",
    "system_status":"FAULT",
    "street_address":"2000 Main St.",
    "city":"Hawarden",
    "state":"IA",
    "postal_code":"51023"
  },
  {
    "farm_id":2,
    "name":"ShadowBrook Farm",
    "system_status":"OK",
    "street_address":"2201 W Denton Rd",
    "city":"Lincoln",
    "state":"NE",
    "postal_code":"68523"
  }
]
```

Note that the **system_status** of a farm is "FAULT" if *any* barn within the farm has a status that
is not "OK". 

#### Locations within a Farm

When the user chooses a farm, the app will need a list of its locations, so that the user can
then select a particular location. This list can be obtained by sending the following GET message:

```
wget http://<base_uri>/farms/<farm_id>/locations.json?user_credentials=<single_access_token>
```

The **farm_id** above is the farm_id obtained from the *farms.json* query described in the
previous section or from the Login response. The cloud server then responds with the
list of locations, as follows. 

```
[
  {
    "location_id":9,
    "name":"Clarke St.",
    "system_status":"FAULT",
    "street_address":"100 Clarke St.",
    "postal_code":"51023",
    "city":"Des Moines",
    "state":"IA"
  },
  {
    "location_id":10,
    "name":"Vanderbilt",
    "system_status":"OK",
    "street_address":"300 Vanderbilt St.",
    "postal_code":"51023","city":"Des Moines",
    "state":"IA"
  }
]
```

Again, the **system_status** of a location is "FAULT" if *any* barn within the location has a status that
is not "OK". 

#### Barns within a Location

When the user chooses a location, the app will need a list of its barns, so that the user can
then select a particular barn. This list can be obtained by sending the following GET message:

```
wget http://<base_uri>/locations/<location_id>/barns.json?user_credentials=<single_access_token>
```

The **location_id** above is the location_id obtained from the *locations.json* query described in the
previous section or from the Login response. The cloud server then responds with the
list of barns, as follows. 

```
[
  {
    "barn_id":1,
    "name":"East Barn",
    "system_status":"FAULT"
  },
  {
    "barn_id":2,
    "name":"West Barn",
    "system_status":"OK"
  }
]
```

<a name="readings"/>
### Current Readings
The current environmental readings at a barn include the following:

*	3x temperature
*	humidity
*	water total
*	CO sensor
*	air quality sensor
*	2x IR feeds sensors
*	2x curtain states
*	3x brooder heater states
*	3x vent fan speeds

#### Getting the last readings 

The mobile app (or any authorized external app) can get the last reported readings for a barn by sending
a GET message to the following URL.

```
wget http://<base_uri>/barns/<barn_id>/last_reading.json?user_credentials=<single_access_token>
```

For example, to see the last reading for the barn whose ID is 9 in JSON format, use:

```
http://<base_uri>/barns/9/last_reading.json?user_credentials=<single_access_token>
```

The response will be in the following format:

```
{
    "system_status": "OK",
    "barn_name": "West Barn",
    "reported_at": "2013-07-24T02:21:17Z",
    "air_quality": "OK",
    "humidity": 66,
    "propane_total": 998,
    "CO":"OK",
    "AC_power": OK",
    "water_total": 1000,
    "temperatures": [{"value":70}, {"value":73}, {"value":72}],
    "ir_feeds": [{"status":"OK"}, {"status":"OK"}],
    "curtain_states": [{"status":"Open"}, {"status":"Partial"}],
    "brooder_heater_states": [{"status":"On"}, {"status":"On"}, {"status":"Off"}],
    "vent_fans": [{"value":40}, {"value":10}, {"value":50}]
}
```

The system status has a value of "OK" only if all readings are normal or reported as "OK". Otherwise, it will have a value of "Fault". The possible values of other fields are shown below. 

| Field         | Description    | Values             |
| ------------- | -------------- |---------------------
| system_status | System status  | OK, Fault          |
| air_quality   | Air quality    | OK, Poor           |
| CO            | Carbon monoxide| OK, High           |
| AC_power      | AC power       | OK, High, Low, Off |

### Reporting current readings

#### Request

The current readings can be reported to the cloud server using a curl command in the following format:

```
curl  -H "Content-Type: application/json"  -X POST -d '{
  "barn_id":9, 
  "humidity":66, 
  "air_quality":"OK",
  "system_status":"OK", 
  "temperatures_attributes":[{"value":22}, {"value":24}, {"value":25}],
  "AC_power":"OK", 
  "CO":"OK", 
  "water_total":1000, 
  "propane_total":998,
  "ir_feeds_attributes":[{"status":"OK"}, {"status":"OK"}],
  "curtain_states_attributes":[{"status":"Open"}, {"status":"Partial"}],
  "brooder_heater_states_attributes":[{"status":"On"}, {"status":"On"}, {"status":"Off"}],
  "vent_fans_attributes":[{"value":40}, {"value":10}, {"value":50}]
}' http://<base_uri>/readings.json?user_credentials=<single_access_token>
```

Note that the URL above contains the single access token obtained from the login response message. 
It must always be appended to the URL as shown above, using the user credentials parameter. 

The _entire_ message above must be sent at periodic intervals. Partial messages can result in
inconsistent data. 

#### Response

The Web application responds to the above request in the following JSON format:

```
{ 
  "AC_power":"OK",
  "CO":"OK",
  "air_quality":"OK",
  "created_at":"2014-02-17T19:30:43Z",
  "humidity":66,"id":27,
  "location_id":9,
  "propane_total":998,
  "reported_at":"2014-02-17T19:30:43Z",
  "system_status":"OK",
  "updated_at":"2014-02-17T19:30:43Z",
  "water_total":1000
}
```

<a name="events"/>
### Event Reports

The controller can report a variety of events to the server. Each event has a unique number, as shown 
below. If the number is greater than 1,000, the event is an _alarm_ indication, i.e., something is wrong. 
Otherwise, events can be commands or informational. 

#### Event numbers and descriptions

```
        [1, "Controller started"],
        [10, "AC power is on and OK"],
        [1010, "AC power is high"],
        [1011, "AC power is low (brownout condition)"],
        [1012, "AC power is off"],
        [20, "CO level is OK"],
        [1020, "CO level is high"],
        [30, "Air quality is OK"],
        [1030, "Air quality is poor"],
        [40, "Brooder heater is commanded on"],
        [41, "Brooder heater is commanded off"],
        [50, "Vent fan is commanded on"],
        [51, "Vent fan is commanded off"],
        [60, "Curtain raise operation started"],
        [61, "Curtain raise operation ended"],
        [1061, "Curtain raise operation timed out"],
        [65, "Curtain lower operation started"],
        [66, "Curtain lower operation ended"],
        [1066, "Curtain lower operation timed out"],
        [70, "Water flow is not continously on"],
        [1070, "Water flow on timeout reached"],
        [80, "Feed present"],
        [1080, "Feed is empty"]
```

#### Getting the last reported event

The mobile app (or any external authorized app) can get the last event reported for a barn
by sending a GET message to the following URL.

```
wget http://<base_uri>/barns/<barn_id>/last_event_report.json
```

For example, to see the last event report for the barn whose ID is 9 in JSON format, go to:

```
http://<base_uri>/barns/9/last_event_report.json
```

The event report will be in the following format:

```
{
    "barn_name": "West Barn",
    "event_code": 1070,
    "description": "Water flow on timeout reached",
    "reported_at": "2013-08-31T04:44:13Z"
}
```

#### Reporting an event

An event can be reported to the cloud server by sending the equivalent of the curl command below:

```
curl  -H "Content-Type: application/json"  -X POST -d "{"location_id":9, "event_code": <event_code> }"
http://<base_uri>/event_reports.json?user_credentials=<single_accesss_token>
```

For example, to report that the CO level is high at location ID 9, the following JSON message is sent:

```
{
  "barn_id": 9,
  "event_code": 1020,
}
```


#### Response

If the server processes the event successfully, it responds with a JSON message containing the 
same values as the request message. If not successful, it responds with a 401 or other 
appropriate HTTP error code.

<a name="shipments"/>
### Shipments

The cloud server tracks shipments of pigs to a particular barn.

#### Reporting a new shipment

When a new shipment of pigs arrives, the shipment information can be sent to the cloud server
using the POST message below:


```
curl  -H "Content-Type: application/json"  -X POST -d '{
  "barn_id":9, 
  "shipment_date": "2014-03-29", 
  "total_pigs": 35,
  "total_doa": 2, 
  "pig_supplier": "Best Hogs, Inc."
}' http://<base_uri>/shipments.json?user_credentials=<single_access_token>
```

The *total_pigs* fields is the total number of pigs in the shipment, and *total_doa* is the number
dead on arrival.

The server will respond with HTTP status code 200 on success, otherwise an error code
will be returned. 

#### Fetching the last shipment record

The mobile app can get the most recent shipment record for a barn by sending a GET message 
to the following URL:

```
wget http://<base_uri>/barns/<barn_id>/last_shipment.json?user_credentials=<single_access_token>
```

The server will respond with a shipment record in the following format:

```
{
  "barn_id":9, 
  "shipment_date": "2014-03-29", 
  "total_pigs": 35,
  "total_doa": 2, 
   "total_inventory": 68,
  "pig_supplier": "Best Hogs, Inc."
}
```

The *total_inventory* field is the total number of pigs in the barn after the pigs in the last shipment
were added.

<a name="inventory"/>
### Inventory

The cloud server keeps track of the inventory of pigs at each barn. The daily inventory report 
contains zero or more pig death records and zero or more pig treatment records. Each pig death record contains 
the total number of pigs that died that day of a particular cause. For example, if 3 pigs died
of belly rupture and 1 pig died due to humpback, then the report would contain two pig death records: one
for belly rupture with a count of 3, and one for humpback with a count of 1. 

Similarly, the pig treatment record contains the number of pigs that were given a particular medicine
at a specific dose that day. If dfferent types of medicines and doses were given to different pigs,
then the report would contain multiple pig treatment records, and the count for each
treatment, as shown in the example below. 

#### Reporting inventory

The inventory of pigs for a given date can be reported by sending a POST message as shown below. 

```
curl  -H "Content-Type: application/json"  -X POST -d '{
  "barn_id":2, "report_date":"2014-04-13", "user_initials":"JB",
  "pig_deaths_attributes":
    [
      {"cause":"Belly rupture", "count":2},
      {"cause":"Humpback","count":1}
    ],
  "pig_treatments_attributes":
    [
      {"medicine_given":"Apralan", "count":5, "dosage":"1200 mg", "how_administered":"Oral"},
      {"medicine_given":"Denagardo", "count":1, "dosage":"500 mg", "how_administered":"Oral"},
    ]
}' http://<base_uri>/inventory_reports.json?user_credentials=${1}

```

The server will respond with HTTP status code 200 on success, otherwise an error code
will be returned along with the reason the data was not accepted. 

#### Fetching the last inventory report

The most recent inventory report for a barn can be obtained by sending a GET message 
to the following URL:

```
wget http://<base_uri>/barns/<barn_id>/last_inventory_report.json?user_credentials=<single_access_token>
```

The server will respond with an inventory report in the following format:

```
{
  "barn_id":2,
  "report_date":"2014-04-13",
  "user_initials":"JB",
  "pig_deaths":
  [
    {"cause":"Belly rupture","count":2},
    {"cause":"Humpback","count":1}
  ],
  "pig_treatments":
  [
    {"count":5,"dosage":"1200 mg","how_administered":"Oral","medicine_given":"Apralan"},
    {"count":1,"dosage":"500 mg","how_administered":"Oral","medicine_given":"Denagardo"},
  ]
}
```

<a name="configuration"/>
### Configuration settings

The sensors have configuration settings and thresholds which can be updated using the Farm
Central Web application. The controller periodially polls the Web application (both in the
cloud and in the SBC) to see if any configuration settings have changed. If so, it changes
the settings as required. 

#### Querying the settings

The settings can be queried by sending a HTTP GET command. For example,

```
wget http://<base_uri>/barns/9/settings.json
```

retrieves all the settings at barn ID 9 in the following format:

```
{
  "barn_name":"West barn",
  "building_temperature":75,
  "propane_sensor_reset":false,
  "water_sensor_reset":false,
  "updated_at":"2013-10-13T17:17:37Z",
  "zone_temperatures":[
    {"id":1,"zone":1,"temperature":72},
    {"id":2,"zone":2,"temperature":72},
    {"id":3,"zone":3,"temperature":72}],
  "curtain_controls":[
    {"id":1,"curtain":1,"action":"None"},
    {"id":2,"curtain":2,"action":"None"}],
  "heater_controls":[
    {"id":1,"heater":1,"action":"None","mode":"Auto","period":0},
    {"id":2,"heater":2,"action":"None","mode":"Auto","period":0}],
  "vent_fan_controls":[
    {"id":1,"fan":1,"mode":"Auto","period":0,"speed":0},
    {"id":2,"fan":2,"mode":"Auto","period":0,"speed":0},
    {"id":3,"fan":3,"mode":"Auto","period":0,"speed":0}]
}
```

Note that the controller can see when the setting were last updated by looking at the *updated_at*
timestamp. Also, the controller must store all the IDs for each sensor setting as shown
above. These ID's will be required in order to sync the settings later, as explained below. 

#### Sync'ing the settings

A setting could be changed using the Cloud Web app. Since the Cloud app cannot tell the SBC Web app 
that the setting has changed, it is up to the controller to keep the settings in sync.
If it sees that the *updated_at* timestamp is more recent in the Cloud app's settings.json, it needs
to update the SBC app's settings to keep them in sync.

It does so by sending a HTTP PUT message, of the form shown below:

```
curl  -H "Content-Type: application/json"  -X PUT -d '{
 "building_temperature":73,
 "propane_sensor_reset":false,
 "water_sensor_reset":false,
 "zone_temperatures_attributes":[
   {"id":7, "zone":1,"temperature":74},
   {"id":8, "zone":2,"temperature":75},
   {"id":9, "zone":3,"temperature":76}],
 "curtain_controls_attributes":[
   {"id":1,"curtain":1,"action":"None"},
   {"id":2,"curtain":2,"action":"Raise"}],
 "heater_controls_attributes":[
   {"id":1,"heater":1,"action":"None","mode":"Auto","period":0},
   {"id":2,"heater":2,"action":"On","mode":"Manual","period":0}],
 "vent_fan_controls_attributes":[
   {"id":1,"fan":1,"mode":"Auto","period":0,"speed":0},
   {"id":2,"fan":2,"mode":"Manual","period":0,"speed":0},
   {"id":3,"fan":3,"mode":"Override","period":0,"speed":1}]
}' http:<base_uri>/barns/9/settings.json?user_credentials=<single_access_token>
```

<a name="schema"/>
## Database Schema

The database schema can be determined by looking at the Ruby files in the
**app/models** folder. Each file there has a corresponding table in the database.

For example, the farm.rb file maps to the *farms* table. Looking inside that file:

```
class Farm < ActiveRecord::Base
  attr_accessible :city, :name, :postal_code, :state, :street_address

  has_many :locations
  has_many :users
  has_many :pictures
  has_many :event_reports, :through => :locations
end
```

Each attr_accessible field is a column in the table. So the farms table has columns named
city, name, postal_code, street address and state. The farm.rb file also shows that
a farm can have many locations, users, pictures and event_reports. These are all one-to-many
relations that are stored using foreign keys. 

Each Ruby file in the app/models folder has a similar structure, and can be used to 
determine the schema of the corresponding database table.
















