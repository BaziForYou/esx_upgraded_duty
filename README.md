# IMPORTANT

Resources provided with this script have additional code alongside the original code to make the hud fully functional at install. If you have these resources already then make sure to remove or disable them to prevent any conflict.

# Resource preview
[Video](https://streamable.com/gv66i1)

# Requirements
- ESX
- MySQL
- Brain

# Download & Installation

- Download https://github.com/BaziForYou/esx_upgraded_duty/archive/main.zip
- Put it in `resources` folder 

## Installation	
- Add this in your `server.cfg` in the following order:
```bash
start esx_upgraded_duty
```

## Make off duty jobs	
- Just need excacute like this:
```bash
CreateOffDutyJob [jobname]
CreateOffDutyJob ambulance
```

## Exports	
#### Client

| Export                         | Description                               | Parameter(s)  | Return type          |
|--------------------------------|-------------------------------------------|---------------|----------------------|
| CheckDuty                      | Returns player is on duty or not          |               | true or false or nil |
| GetOffDutyJobs                 | Returns list of off duty jobs             |               | table                |
| GetOnDutyJobs                  | Returns list of on duty jobs              |               | table                |
| IsJobOnDuty                    | Returns that job is on duty job or not    | string        | true or false or nil |
| IsJobOffDuty                   | Returns that job is off duty job or not   | string        | true or false or nil |

#### Server

| Export                         | Description                               | Parameter(s)  | Return type          |
|--------------------------------|-------------------------------------------|---------------|----------------------|
| CheckDuty                      | Returns player id is on duty or not       | int           | true or false or nil |
| GetOffDutyJobs                 | Returns list of off duty jobs             |               | table                |
| GetOnDutyJobs                  | Returns list of on duty jobs              |               | table                |
| IsJobOnDuty                    | Returns that job is on duty job or not    | string        | true or false or nil |
| IsJobOffDuty                   | Returns that job is off duty job or not   | string        | true or false or nil |



# Credits

###  Resources used:
- [esx_duty](https://github.com/qalle-git/esx_duty)
