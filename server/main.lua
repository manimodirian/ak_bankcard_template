---@diagnostic disable: undefined-global
local QBCore = exports['qb-core']:GetCoreObject()

-- --- 1. ADIM: Otomatik Kart Verme ---
RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local bankCard = Player.Functions.GetItemByName('bank_card')
    if not bankCard then
        local info = {
            citizenid = Player.PlayerData.citizenid,
            cardholder = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
            iban = Player.PlayerData.charinfo.account,
            pin = "[DEFAULT_PIN]"
        }
        Player.Functions.AddItem('bank_card', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bank_card'], "add")
    end
end)

-- --- 2. ADIM: PIN Bilgisini Metadata'dan Çekme ---
RegisterNetEvent('[SCRIPT_NAME]:server:PinBilgisiIste', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local cardItem = Player.Functions.GetItemByName('bank_card')
    local pinCode = "[DEFAULT_PIN]"
    
    if cardItem and cardItem.info and cardItem.info.pin then
        pinCode = tostring(cardItem.info.pin)
        if pinCode == "0" or string.len(pinCode) < 4 then
            pinCode = "[DEFAULT_PIN]"
        end
    end
    TriggerClientEvent('[SCRIPT_NAME]:client:PinAc', src, pinCode)
end)

-- --- 3. ADIM: VERİLERİ GETİR ---
RegisterNetEvent('[SCRIPT_NAME]:server:VerileriGetir', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local data = {
        name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
        iban = Player.PlayerData.charinfo.account,
        balance = Player.PlayerData.money.bank
    }
    TriggerClientEvent('[SCRIPT_NAME]:client:BankaMenuAc', src, data)
end)

-- --- 4. ADIM: ENVANTERDEN KULLANIM ---
QBCore.Functions.CreateUseableItem("bank_card", function(source)
    TriggerClientEvent('[SCRIPT_NAME]:client:KartKontrol', source)
end)

-- --- 5. ADIM: BANKA İŞLEMLERİ ---
RegisterNetEvent('[SCRIPT_NAME]:server:BankaIslemi', function(action, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    amount = math.floor(tonumber(amount) or 0)
    if amount <= 0 then return end

    local success = false
    if action == "deposit" then
        if Player.Functions.RemoveMoney('cash', amount, "ATM Deposit") then
            Player.Functions.AddMoney('bank', amount, "ATM Deposit")
            success = true
        end
    elseif action == "withdraw" then
        if Player.PlayerData.money.bank >= amount then
            if Player.Functions.RemoveMoney('bank', amount, "ATM Withdraw") then
                Player.Functions.AddMoney('cash', amount, "ATM Withdraw")
                success = true
            end
        end
    end

    if success then
        local currentBank = Player.Functions.GetMoney('bank')
        TriggerClientEvent('[SCRIPT_NAME]:client:NUIyeGonder', src, {
            type = "updateBalance",
            balance = currentBank
        })
        TriggerClientEvent('QBCore:Notify', src, "Transaction Successful: $" .. amount, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Transaction Failed or Insufficient Funds!", "error")
    end
end)