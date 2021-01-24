RegisterCommand('CreateOffDutyJob',function(source,args,rawCommand)
  if tonumber(source) and tonumber(source) ~= 0 then return end
  local GetSql = function(query,params)
    local res,ret
    MySQL.Async.fetchAll(query,params,function(r)
      ret = r
      res = true
    end)
    while not res do Wait(0); end
    return ret
  end

  local ExecuteSql = function(query,params)
    local res
    MySQL.Async.execute(query,params,function()
      res = true
    end)
    while not res do Wait(0); end
  end

  wantedjobname = args[1]
  if not wantedjobname then print('Please enter job name to create off duty for them') return end
  local jobtabledata = GetSql('SELECT * FROM jobs WHERE name = "'..wantedjobname..'"',{})
  
  
  if not (#jobtabledata > 0) then print('Please enter Valid job name to create off duty for them') return end
  if not jobtabledata[1].label then print('I cant find Job label from jobs tabel') return end
  
  local jobgradetabledata = GetSql('SELECT * FROM job_grades WHERE job_name = "'..wantedjobname..'"',{})
  local gradecounts = #jobgradetabledata
  
  if not (gradecounts > 0) then print('I cant find Job grades from job_grades tabel') return end
  
  print("Starting. No players should join during this time, and you should not shut down your server until the completion prompt has been displayed.")
  local mainjoblabel = jobtabledata[1].label
  
  ExecuteSql("INSERT INTO jobs SET name=@name,label=@label",{
	  ['@name']          = "off"..wantedjobname,
	  ['@label']         = "(Off-Duty) "..mainjoblabel
  })
  
  print("Jobs injected now going for grades.")
  

  for k,v in pairs(jobgradetabledata) do
	ExecuteSql("INSERT INTO job_grades SET job_name=@job_name,grade=@grade,name=@name,label=@label,salary=@salary",{
		['@job_name']      = "off".. v.job_name,
		['@grade']         = v.grade,
		['@name']          = v.name,
		['@label']         = v.label,
		['@salary']        = v.salary
	})
  end
  print("Done. It is now safe to restart your server.")
  print("Now you have off duty jobs for "..wantedjobname.." and its off"..wantedjobname.." on "..gradecounts.." grades.")
  print("It is now safe to restart your server.")
end,true)

