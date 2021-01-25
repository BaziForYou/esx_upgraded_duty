# Features
- Create off duty jobs just with one command
- Much optimizer than others and get low usage (0.1 and 0.20% on idle)
- Have lots of exports for scripting like blocking something for on duty on other scripts
- Multi help options on config
- Multi notify options on config
- Multi-color for on and off duty
- Multi-color for on and off duty
- Added more locates
- Can have multi-location for jobs just on configs
- Can enter any off duty jobs (because someone doesn't like to have a job like offpolice)
- Added one method and config to don't check all the zones to get lower usage
- Clean coding

# IMPORTANT

Resources provided with this script have additional code alongside the original code to make the duty fully functional at install. If you have these resources already then make sure to remove or disable them to prevent any conflict.

# Resource preview
[Video](https://streamable.com/gv66i1)

# Requirements
- ESX
- MySQL
- Brain

# Download & Installation

- Download https://github.com/BaziForYou/esx_upgraded_duty/archive/main.zip
- Put it in the `resources` folder 

## Installation	
- Add this in your `server.cfg` in the following order:
```bash
start esx_upgraded_duty
```

## Make off duty jobs	
- Just need to execute the command in your `cmd` like this:
```bash
CreateOffDutyJob [jobname]
CreateOffDutyJob ambulance
```

## Exports	
#### Client

| Export                         | Description                               | Parameter(s)  | Return type          |
|--------------------------------|-------------------------------------------|---------------|----------------------|
| CheckDuty                      | Returns player is on duty or not          |               | true or false or nil |
| GetOffDutyJobs                 | Returns a list of off duty jobs           |               | table                |
| GetOnDutyJobs                  | Returns a list of on-duty jobs            |               | table                |
| IsJobOnDuty                    | Returns that job is on duty job or not    | string        | true or false or nil |
| IsJobOffDuty                   | Returns that job is off duty job or not   | string        | true or false or nil |

#### Server

| Export                         | Description                               | Parameter(s)  | Return type          |
|--------------------------------|-------------------------------------------|---------------|----------------------|
| CheckDuty                      | Returns player id is on duty or not       | int           | true or false or nil |
| GetOffDutyJobs                 | Returns a list of off duty jobs           |               | table                |
| GetOnDutyJobs                  | Returns a list of on-duty jobs            |               | table                |
| IsJobOnDuty                    | Returns that job is on duty job or not    | string        | true or false or nil |
| IsJobOffDuty                   | Returns that job is off duty job or not   | string        | true or false or nil |



# Credits

###  Resources used:
- [esx_duty](https://github.com/qalle-git/esx_duty)
