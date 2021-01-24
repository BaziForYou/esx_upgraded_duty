ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local dutyjobsinfo = {}
local offdutyjobsinfo = {}
local OnDutyJobsList = {}
local OffDutyJobsList = {}

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if not dutyjobsinfo[v.job] then OnDutyJobsList[#OnDutyJobsList+1] = v.job end
		if not offdutyjobsinfo[v.offjob] then OffDutyJobsList[#OffDutyJobsList+1] = v.offjob end
		dutyjobsinfo[v.job] = v.offjob
		offdutyjobsinfo[v.offjob] = v.job
	end
end)

RegisterServerEvent('esx_duty:toggleduty')
AddEventHandler('esx_duty:toggleduty', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if dutyjobsinfo[job] then
        xPlayer.setJob(dutyjobsinfo[job], grade)
		TriggerClientEvent('esx_duty:Notify', source, 'inform', _U('offduty'))
    elseif offdutyjobsinfo[job] then
        xPlayer.setJob(offdutyjobsinfo[job], grade)
        TriggerClientEvent('esx_duty:Notify', source, 'inform', _U('onduty'))
    end
end)


--Exports

function CheckDuty(source)
	if not source then return nil end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerjob = xPlayer.job.name
	
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
