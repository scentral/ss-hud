-- send ped health to html
local ped = PlayerPedId()

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

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)

    SetMinimapComponentPosition('minimap', 'L', 'B', -0.0050, -0.030, 0.170, 0.200)

    SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.020, 0.115, 0.125, 0.120)
  
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.040, -0.01, 0.306, 0.237)
    while true do
        Citizen.Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        SetBlipAlpha(GetNorthRadarBlip(), 0)

        local waypointBlip = GetFirstBlipInfoId(8)
        if DoesBlipExist(waypointBlip) then
            SetBlipAsShortRange(waypointBlip, true)
        end
    end
end)

-- Hide radar when player is not in a vehicle
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if not IsPedInAnyVehicle(ped, false) then
            DisplayRadar(false)
        else
            DisplayRadar(true)
        end 
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end
    end
end)
