QBCore = exports['qb-core']:GetCoreObject()

local xhairActive = false
local disableXhair = false

RegisterNetEvent("hud:client:ToggleCross", function(v)
    disableXhair = v
end)

CreateThread(function()
    while true do
        Wait(500)
        local get_ped = PlayerPedId()
        local get_ped_veh = GetVehiclePedIsIn(get_ped, false)
        local aiming = IsAimCamActive(get_ped)
        local weapon = GetSelectedPedWeapon(get_ped)
		local unarmed = (weapon == GetHashKey("WEAPON_UNARMED"))

        if not disableXhair and not xhairActive then
            xhairActive = true
            SendNUIMessage("xhairHide")
        elseif xhairActive and disableXhair and aiming then
            xhairActive = false
            SendNUIMessage("xhairShow")
        elseif unarmed then
            SendNUIMessage("xhairHide")
        elseif not aiming then
            SendNUIMessage("xhairHide")
        elseif disableXhair and aiming then
            xhairActive = false
            SendNUIMessage("xhairShow")
        end
    end
end)

RegisterNUICallback('hideReticle', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleCrosshair")
end)