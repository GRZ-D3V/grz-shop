Citizen.CreateThread(function()
    for _,v in pairs(Config.Shop) do
      if v[5] == 1 then   
        local blip = AddBlipForCoord(v[2]) SetBlipSprite (blip, v[6]) SetBlipDisplay(blip, v[7]) SetBlipScale  (blip, v[8]) SetBlipColour (blip, v[9]) SetBlipAsShortRange(blip, true) BeginTextCommandSetBlipName('STRING') AddTextComponentSubstringPlayerName(v[10]) EndTextCommandSetBlipName(blip)
      end
      if v[4] == 1 then   
        local hash = GetHashKey(v[3]) while not HasModelLoaded(hash) do RequestModel(hash) Wait(20) end ped = CreatePed("PED_TYPE_CIVFEMALE", v[3], v[2], false, true) SetBlockingOfNonTemporaryEvents(ped, true) SetEntityInvincible(ped, true) FreezeEntityPosition(ped, true)
      end
    end

    --[[
    for _,v in pairs(Config.Blip) do
      Zone = AddBlipForRadius(v[1], v[2]) SetBlipSprite(Zone, 1.0) SetBlipColour(Zone, v[3]) SetBlipAlpha(Zone, v[4])
      local Zoneblip = AddBlipForCoord(v[1]) SetBlipScale  (Zoneblip, 0.75) SetBlipSprite (Zoneblip, 84) SetBlipColour (Zoneblip, v[3]) SetBlipAsShortRange(Zoneblip, true) BeginTextCommandSetBlipName('STRING') AddTextComponentSubstringPlayerName(v[5]) EndTextCommandSetBlipName(Zoneblip)
    end ]]--
    
end)