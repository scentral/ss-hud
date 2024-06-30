-- send ped health to html

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        local PlayerHealth = GetEntityHealth(PlayerPedId()) - 100
        local PlayerArmour = GetPedArmour(PlayerPedId())

        SendNUIMessage({
            type = "hud",
            health = PlayerHealth
        })

        if PlayerArmour > 0 then
            SendNUIMessage({
                type = "armour",
                show = true,
                armour = PlayerArmour
            })
        else
            SendNUIMessage({
                type = "armour",
                show = false
            })
        end
    end
end)

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(2)
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            SendNUIMessage({
                type = "radar",
                show = false
            })
            DisplayRadar(false)
        else
            SendNUIMessage({
                type = "radar",
                show = true
            })
            DisplayRadar(true)
        end 

        if IsPedSwimmingUnderWater(ped) then
            local TimeRemaining = GetPlayerUnderwaterTimeRemaining(PlayerId())
            TimeRemaining = (TimeRemaining / 60) * 100
            SendNUIMessage({
                type = "breath",
                show = true,
                time = TimeRemaining
            })
        else
            SendNUIMessage({
                type = "breath",
                show = false
            })
        end
    end
end)