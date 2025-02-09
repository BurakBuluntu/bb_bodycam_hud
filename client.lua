ESX = nil
local yeniveri = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	veriler()
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(5000)
	  PlayerData = ESX.GetPlayerData()
	  veriler()
    end
end)

function veriler()
	Citizen.Wait(1000)
	local meslek = ''.. PlayerData.job.label .. ' - ' .. PlayerData.job.grade_label ..''

		ESX.TriggerServerCallback('brkblnt_bodycam:isimcek', function(result)
			brkblntmetin = ''.. result .. ' [ID: ' .. GetPlayerServerId(PlayerId()) .. ']'
			TriggerEvent('bodycam:show', meslek, brkblntmetin)
		end, GetPlayerServerId(PlayerId()))
end

RegisterNetEvent("bodycam:show")
AddEventHandler("bodycam:show", function(daner, job)
--AddEventHandler("bodycam:show", function(daner, job, brkblnt)
    local year , month, day , hour , minute , second  = GetLocalTime()

    if string.len(tostring(minute)) < 2 then
            minute = '0' .. minute
    end
    if string.len(tostring(second)) < 2 then
            second = '0' .. second
    end
	
	if not toggleui then

        SendNUIMessage({
            date = day .. '/'.. month .. '/' .. year .. ' ' .. hour .. ':' .. minute .. ':' .. second,
            daneosoby = daner,
            ranga = job,
            open = true,
        })
	else
		TriggerEvent("bodycam:close")
	end
end)

RegisterNetEvent("bodycam:close")
AddEventHandler("bodycam:close", function()
    SendNUIMessage({
        open = false
    })
end)

toggleui = false
RegisterCommand('bodycam', function()
	if not toggleui then

		TriggerEvent("bodycam:show")
	else
		--TriggerEvent("bodycam:close")
	end

	toggleui = not toggleui
end)

burakbuluntu=true
haritacildi =false

if burakbuluntu then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)

			if IsPauseMenuActive() and not IsPaused then
				haritacildi = true
				TriggerEvent("bodycam:close")
			elseif not IsPauseMenuActive() then
				haritacildi = false
			end
			while haritacildi do
				Citizen.Wait(1000)
				veriler()
				haritacildi = false
			end
		end
	end)
end
