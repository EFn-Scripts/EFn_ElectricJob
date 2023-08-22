if Config.Framework =='esx' then
	ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Framework =='QBCore' then
	QBCore = exports['qb-core']:GetCoreObject()
else
	print('no framework set or standalone')
end

RegisterServerEvent('GetPaid')
AddEventHandler('GetPaid', function(boob)
    if Config.Framework == 'esx' then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local pCoords = GetEntityCoords(GetPlayerPed(_source))
        if not xPlayer then return end
        if #(pCoords - boob) > 10 then print('Mod menu exploit') return end
        if Config.Payment == 'cash' then
            xPlayer.addMoney(Config.JobPay)
        elseif Config.Payment == 'bank' then
            xPlayer.addAccountMoney('bank', Config.JobPay)
        end
    elseif Config.Framework == 'QBCore' then
        local _source = source
        local Player = QBCore.Functions.GetPlayer(_source)
        local pCoords = GetEntityCoords(GetPlayerPed(_source))
        if not Player then return end
        if #(pCoords - boob) > 10 then print('Mod menu exploit') return end
        if Config.Payment == 'cash' then
            Player.Functions.AddMoney('cash', Config.JobPay)
        elseif Config.Payment == 'bank' then
            Player.Functions.AddMoney('bank', Config.JobPay, "Electric Job")
        end
    else
        print('no framework selected')
    end
end)

RegisterServerEvent('setlight:on')
AddEventHandler('setlight:on', function(location)
    local loc = location
    TriggerClientEvent("setlight:on", -1, loc)
end)

RegisterServerEvent('setlight:off')
AddEventHandler('setlight:off', function(location)
    local loc = location
    TriggerClientEvent("setlight:off", -1, loc)
end)
