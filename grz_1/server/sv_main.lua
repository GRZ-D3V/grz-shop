ESX             = nil
local availableJobs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('grz_1:Shop')
AddEventHandler('grz_1:Shop', function(id, label, item, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(item)
    
    if xPlayer.getMoney() >= price then
        if id == 1 then
            if Config.Weight then
                if xPlayer.canCarryItem(item, 1) then
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.removeMoney(price)
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('info'), '',  _U('AchatShop')..'x1 ~y~'..label, 'CHAR_DOM', 1)
                else
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('info'), '', _U('PasPlace'), 'CHAR_DOM', 1)
                end 
            else
                if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('info'), '', _U('PasPlace'), 'CHAR_DOM', 1)
                else
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.removeMoney(price)
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('info'), '',  _U('AchatShop')..'x1 ~y~'..label, 'CHAR_DOM', 1)
                end
            end    
        elseif id == 2 then
            if xPlayer.getWeapon(item) then
                TriggerClientEvent('esx:showAdvancedNotification', source, _U('armurerie'), '', _U('DejaArme'), 'CHAR_DOM', 1)
            else
                xPlayer.addWeapon(item, 200)
                xPlayer.removeMoney(price)
                TriggerClientEvent('esx:showAdvancedNotification', source, _U('armurerie'), '', _U('AchatArme')..label, 'CHAR_DOM', 1)
            end
        end

    else
        if id == 1 then
            TriggerClientEvent('esx:showAdvancedNotification', source, _U('info'), '', _U('PasArgent'), 'CHAR_DOM', 1)
        elseif id == 2 then
            TriggerClientEvent('esx:showAdvancedNotification', source, _U('armurerie'), '', _U('PasArgent'), 'CHAR_DOM', 1)
        end
    end
end)

RegisterServerEvent('grz_1:ShopSell')
AddEventHandler('grz_1:ShopSell', function(id, label, item, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(item).count
    if sourceItem >= 1 then
        if id == 1 then
                    xPlayer.removeInventoryItem(item, 1)
                    xPlayer.addMoney(price)
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Vous venez de faire ' .. price .. '$ avec 1 ' .. label .. ' !'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Vous n\'avez pas de ' .. label .. ''})
    end
end)


MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT name, label FROM jobs WHERE whitelisted = @whitelisted', {
		['@whitelisted'] = false
	}, function(result)
		for i=1, #result, 1 do
			table.insert(availableJobs, {
				job = result[i].name,
				label = result[i].label
			})
		end
	end)
end)

ESX.RegisterServerCallback('esx_joblisting:getJobsList', function(source, cb)
	cb(availableJobs)
end)

RegisterServerEvent('esx_joblisting:setJob')
AddEventHandler('esx_joblisting:setJob', function(job)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		for k,v in ipairs(availableJobs) do
			if v.job == job then
				xPlayer.setJob(job, 0)
				break
			end
		end
	end
end)
