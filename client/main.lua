---@diagnostic disable: undefined-global
local QBCore = exports['qb-core']:GetCoreObject()
local atmDui = nil 
local atmCam = nil          
local currentAtmEntity = nil 

local atmOffsets = {
    [GetHashKey("prop_atm_01")] = { x = 0.0, y = -0.40, z = 1.13 },   
    [GetHashKey("prop_atm_02")] = { x = -0.11, y = -0.40, z = 1.13 }, 
    [GetHashKey("prop_atm_03")] = { x = -0.11, y = -0.40, z = 1.13 }, 
    [GetHashKey("prop_vic_atm_01")] = { x = 0.0, y = -0.40, z = 1.13 },
    [GetHashKey("prop_vic_atm_02")] = { x = 0.0, y = -0.40, z = 1.13 },
    [GetHashKey("prop_ch_atm_01a")] = { x = 0.0, y = -0.40, z = 1.13 },
    [GetHashKey("prop_ch_atm_01b")] = { x = 0.0, y = -0.40, z = 1.13 },
}

local function GetNearestAtm()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    
    local atmModels = { 
        "prop_atm_01", "prop_atm_02", "prop_atm_03", 
        "prop_vic_atm_01", "prop_vic_atm_02", 
        "prop_ch_atm_01a", "prop_ch_atm_01b" 
    }
    
    for _, model in ipairs(atmModels) do
        local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.0, GetHashKey(model), false, false, false)
        if entity and entity ~= 0 then return entity end
    end
    return nil
end

local function FocusAtmCamera(entity)
    if not entity or entity == 0 then return end

    local playerPed = PlayerPedId()
    local modelHash = GetEntityModel(entity)
    
    local offset = atmOffsets[modelHash] or { x = 0.0, y = -0.65, z = 1.05 }

    local camPos = GetOffsetFromEntityInWorldCoords(entity, offset.x, offset.y, offset.z)
    local targetPos = GetOffsetFromEntityInWorldCoords(entity, offset.x, 0.0, offset.z)

    atmCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(atmCam, camPos.x, camPos.y, camPos.z)
    PointCamAtCoord(atmCam, targetPos.x, targetPos.y, targetPos.z)
    
    SetCamActive(atmCam, true)
    RenderScriptCams(true, true, 800, true, true)

    SetEntityAlpha(playerPed, 0, false)
end

local function ResetCamera()
    local playerPed = PlayerPedId()
    if atmCam then
        RenderScriptCams(false, true, 800, true, false)
        DestroyCam(atmCam, false)
        atmCam = nil
    end
    ResetEntityAlpha(playerPed)
    currentAtmEntity = nil
end

local function CreateAtmDui()
    if not atmDui then
        local txdName = "AK_BANK_TEXTURE"
        local txnName = "screen_render"
        
        atmDui = CreateDui("nui://ak_bankcard/html/ui.html", 512, 512)
        local duiHandle = GetDuiHandle(atmDui)

        local txd = CreateRuntimeTxd(txdName)
        CreateRuntimeTextureFromDuiHandle(txd, txnName, duiHandle)

        local atmModels = {
            "prop_atm_01", "prop_atm_02", "prop_atm_03", 
            "prop_vic_atm_01", "prop_vic_atm_02", 
            "prop_ch_atm_01a", "prop_ch_atm_01b"
        }

        local textureNames = {
            'script_rt_atm_screen',
            'prop_atm_screen_01',
            'prop_atm_02_screen',
            'prop_atm_03_screen',
            'script_rt_atm_screen_01'
        }

        for _, model in ipairs(atmModels) do
            for _, tex in ipairs(textureNames) do
                AddReplaceTexture(model, tex, txdName, txnName)
            end
        end
    end
end

local function DestroyAtmDui()
    if atmDui then
        DestroyDui(atmDui)
        atmDui = nil
        
        local atmModels = {
            "prop_atm_01", "prop_atm_02", "prop_atm_03", 
            "prop_vic_atm_01", "prop_vic_atm_02", 
            "prop_ch_atm_01a", "prop_ch_atm_01b"
        }
        
        local textureNames = {
            'script_rt_atm_screen',
            'prop_atm_screen_01',
            'prop_atm_02_screen',
            'prop_atm_03_screen',
            'script_rt_atm_screen_01'
        }

        for _, model in ipairs(atmModels) do
            for _, tex in ipairs(textureNames) do
                RemoveReplaceTexture(model, tex)
            end
        end
    end
end

exports['qb-target']:AddTargetModel({"prop_atm_01", "prop_atm_02", "prop_atm_03", "prop_vic_atm_01", "prop_vic_atm_02", "prop_ch_atm_01a", "prop_ch_atm_01b"}, {
    options = {
        {
            type = "client",
            event = "ak_bankcard:client:KartKontrol",
            icon = "fas fa-credit-card",
            label = "Kartı Yerleştir",
        },
    },
    distance = 1.5
})

RegisterNetEvent('ak_bankcard:client:KartKontrol', function(data)
    local hasItem = QBCore.Functions.HasItem("bank_card")

    if hasItem then
        if data and data.entity then
            currentAtmEntity = data.entity
        else
            currentAtmEntity = GetNearestAtm()
        end

        if not currentAtmEntity or currentAtmEntity == 0 then
            QBCore.Functions.Notify("Yakınlarda bir ATM bulunamadı!", "error")
            return
        end

        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
        
        QBCore.Functions.Progressbar("atm_card", "Kart okunuyor...", 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('ak_bankcard:server:PinBilgisiIste')
        end, function()
            ClearPedTasks(PlayerPedId())
            currentAtmEntity = nil
            QBCore.Functions.Notify("İşlem iptal edildi.", "error")
        end)
    else
        QBCore.Functions.Notify("Üzerinizde banka kartı yok!", "error")
    end
end)

RegisterNetEvent('ak_bankcard:client:PinAc', function(pinCode)
    CreateAtmDui() 
    if currentAtmEntity then FocusAtmCamera(currentAtmEntity) end
    SetNuiFocus(true, true) 

    local payload = { type = "openPin", pin = pinCode }
    
    -- HATALI KISIM DÜZELTİLDİ: = true olarak değiştirildi
    SendNUIMessage({ type = "openPin", pin = pinCode, hideScreen = true })
    
    Citizen.CreateThread(function()
        Citizen.Wait(1000) 
        if atmDui then
            SendDuiMessage(atmDui, json.encode(payload))
        end
    end)
end)

RegisterNetEvent('ak_bankcard:client:BankaMenuAc', function(data)
    if not atmDui then CreateAtmDui() end 

    local payload = { type = "openBank", name = data.name, iban = data.iban, balance = data.balance }
    
    -- HATALI KISIM DÜZELTİLDİ: = true olarak değiştirildi
    SendNUIMessage({ type = "openBank", name = data.name, iban = data.iban, balance = data.balance, hideScreen = true })
    
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        if atmDui then
            SendDuiMessage(atmDui, json.encode(payload))
        end
    end)
end)

-- Callback'ler Temizlendi
RegisterNUICallback('doAction', function(data, cb) 
    TriggerServerEvent('ak_bankcard:server:BankaIslemi', data.action, data.amount) 
    cb('ok') 
end)

RegisterNUICallback('transferMoney', function(data, cb) 
    TriggerServerEvent('ak_bankcard:server:HavaleYap', data.iban, data.amount) 
    cb('ok') 
end)

RegisterNUICallback('changePin', function(data, cb) 
    TriggerServerEvent('ak_bankcard:server:PinGuncelle', data.pin) 
    cb('ok') 
end)

RegisterNUICallback('getHistory', function(data, cb) 
    TriggerServerEvent('ak_bankcard:server:GecmisiGetir') 
    cb('ok') 
end)

RegisterNUICallback('pinSuccess', function(data, cb) 
    TriggerServerEvent('ak_bankcard:server:VerileriGetir') 
    cb('ok') 
end)

RegisterNUICallback('pinError', function(data, cb) 
    QBCore.Functions.Notify("Hatalı PIN Kodu!", "error") 
    cb('ok') 
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    ResetCamera()
    DestroyAtmDui() 
    cb('ok')
end)

RegisterNetEvent('ak_bankcard:client:KapatZorla', function()
    SetNuiFocus(false, false)
    ResetCamera()
    DestroyAtmDui()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    ResetCamera()
    DestroyAtmDui()
end)

RegisterNetEvent('ak_bankcard:client:NUIyeGonder', function(data)
    SendNUIMessage(data)
    if atmDui then
        SendDuiMessage(atmDui, json.encode(data))
    end
end)