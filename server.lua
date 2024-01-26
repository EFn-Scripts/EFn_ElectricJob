ESX, QBCore = nil, nil

if Config.Framework  == 'esx' then
    pcall(function() ESX = exports[Config.Strings.esxName]:getSharedObject() end)
    if ESX == nil then
        TriggerEvent(Config.Strings.esxMain, function(obj) ESX = obj end)
    end
    
elseif Config.Framework == 'qbcore' then
    TriggerEvent(Config.Strings.qbMain, function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.Strings.qbName]:GetCoreObject()
    end
    
elseif Config.Framework  == 'standalone' then
	-- you can add your own custom framework here
end

RegisterServerEvent('GetPaid')
AddEventHandler('GetPaid', function(homie)
    if Config.Framework == 'esx' then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local pCoords = GetEntityCoords(GetPlayerPed(_source))
        if not xPlayer then return end
        if #(pCoords - homie) > 10 then print('Mod menu exploit') return end
        if Config.Payment == 'cash' then
            xPlayer.addMoney(Config.JobPay)
        elseif Config.Payment == 'bank' then
            xPlayer.addAccountMoney('bank', Config.JobPay)
        end
    elseif Config.Framework == 'qbcore' then
        local _source = source
        local Player = QBCore.Functions.GetPlayer(_source)
        local pCoords = GetEntityCoords(GetPlayerPed(_source))
        if not Player then return end
        if #(pCoords - homie) > 10 then print('Mod menu exploit') return end
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

local resourceName = "EFn_ElectricJob"
local currentVersion = "1.0.0" -- version

PerformHttpRequest(
    "https://api.github.com/repos/EFn-Scripts/EFn_ElectricJob/releases/latest",
    function(statusCode, response, headers)
        if statusCode == 200 then
            local releaseData = json.decode(response)
            local latestVersion = releaseData.tag_name

            if latestVersion > currentVersion then
                print("A new version of " .. resourceName .. " is available. Please update your resource.")
            else
                print(resourceName .. " is up to date.")
            end
        else
            print("Failed to check for updates for " .. resourceName .. ".")
        end
    end,
    "GET",
    "",
    { ["Content-Type"] = "application/json" }
)
