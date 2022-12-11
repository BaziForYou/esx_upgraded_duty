local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX                           = nil
local PlayerData              = {}
local dutyjobsinfo            = {}
local offdutyjobsinfo         = {}
local OnDutyJobsList          = {}
local OffDutyJobsList         = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx_duty:Notify')
AddEventHandler('esx_duty:Notify', function(type, msg, time)
    Config.Notify(type, msg, time)
end)

ShowHelpNotification = function(msg)
    SetTextComponentFormat("DUTYSTRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

ShowFloatingHelpNotification = function(msg, coords)
	AddTextEntry('DUTYSTRING', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('DUTYSTRING')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

DrawText3D = function(coords, text, size, font)
	coords = vector3(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('DUTYSTRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if not dutyjobsinfo[v.job] then OnDutyJobsList[#OnDutyJobsList+1] = v.job end
		if not offdutyjobsinfo[v.offjob] then OffDutyJobsList[#OffDutyJobsList+1] = v.offjob end
		dutyjobsinfo[v.job] = v.offjob
		offdutyjobsinfo[v.offjob] = v.job
	end
    while true do
        local Sleep = 1000
        if ESX and PlayerData.job then
			local playerjob = PlayerData.job.name
			if dutyjobsinfo[playerjob] or offdutyjobsinfo[playerjob] then
				for k,v in pairs(Config.Zones) do
					if playerjob == v.job or playerjob == v.offjob then
						local coords = GetEntityCoords(GetPlayerPed(-1))
						local dist = 999.0
						if Config.DistanceMethod == 'Vdist' then
							dist = Vdist(coords, v.Pos.x, v.Pos.y, v.Pos.z)
						else
							dist = #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z))
						end
						if(dist <= Config.DrawDistance)then
							Sleep = 5
							local r,g,b = 0,255,0
							local duty = _U('duty1')
							if playerjob == v.offjob then duty = _U('duty2') r,g,b = 255,0,0 end
							--DrawMarker(6, v.Pos.x, v.Pos.y, v.Pos.z - 0.975, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, r,g,b, 100, false, true, 2, false, false, false, false)
							if(dist <= v.Size.x)then
								if Config.HelpText == '3DText' then
									DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z),duty,0.75)
								elseif Config.HelpText == 'Floating' then
									--ShowFloatingHelpNotification(duty,vector3(v.Pos.x, v.Pos.y, v.Pos.z))
									exports.ox_target:addBoxZone({
                                    coords = vec3(v.Pos.x, v.Pos.y, v.Pos.z),
                                    size = vec3(2, 2, 2),
                                    rotation = 45,
                                    debug = drawZones,
                                    options = {
                                    {
                                    name = 'mydutymenu',
                                    event = 'privategiles:dutycallback',
                                    icon = 'fa-solid fa-box',
                                    label = 'Duty',
                                    canInteract = function(entity, distance, coords, name)
                                    return true
									end
                                            }
                                        }
                                    })
								else
									--ShowHelpNotification(duty)
								end
								if IsControlJustPressed(0, Keys['E']) then
								TriggerServerEvent('esx_duty:toggleduty')
								end
							end
							if Config.JustCanSeeOne then
								break
							end
						end
					end
				end
			else
				Sleep = 2000
			end
        else
            Sleep = 3000
        end
        Wait(Sleep)
    end
end)


-- Dinger Callbacks
RegisterNetEvent('privategiles:dutycallback', function() 
TriggerServerEvent('esx_duty:toggleduty')
end)

-- Exports


function CheckDuty()
    local playerjob = PlayerData.job.name
	if dutyjobsinfo[playerjob] then
		return true
	elseif offdutyjobsinfo[playerjob] then
		return false
	else
		return nil
	end
end

exports("CheckDuty", CheckDuty)

function GetOffDutyJobs()
    return OffDutyJobsList
end

exports("GetOffDutyJobs", GetOffDutyJobs)

function GetOnDutyJobs()
    return OnDutyJobsList
end

exports("GetOnDutyJobs", GetOnDutyJobs)

function IsJobOnDuty(JobName)
	if dutyjobsinfo[JobName] then
		return true
	else
		return nil
	end
end

exports("IsJobOnDuty", IsJobOnDuty)

function IsJobOffDuty(JobName)
	if offdutyjobsinfo[JobName] then
		return true
	else
		return nil
	end
end

exports("IsJobOffDuty", IsJobOffDuty)
