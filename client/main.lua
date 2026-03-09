---@diagnostic disable: undefined-global

-- TODO: Export QBCore from qb-core resource
-- local QBCore = exports['qb-core']:GetCoreObject()

-- ============================================
-- STEP 1: ATM TARGET SETUP
-- ============================================
-- TODO: Set up qb-target to detect ATM models
-- You need to:
-- 1. Create a target for ATM models
-- 2. Add an option to "Insert Card"
-- 3. Trigger event when player interacts with ATM
--
-- ATM Models to target:
-- "prop_atm_01", "prop_atm_02", "prop_atm_03", 
-- "prop_vic_atm_01", "prop_vic_atm_02",
-- "prop_ch_atm_01a", "prop_ch_atm_01b"

-- Example target setup:
-- exports['qb-target']:AddTargetModel({...}, {
--     options = {
--         {
--             type = "client",
--             event = "ak_bankcard:client:CardControl",
--             icon = "fas fa-credit-card",
--             label = "Insert Card",
--         },
--     },
--     distance = 1.5
-- })


-- ============================================
-- STEP 2: CARD CONTROL AND VALIDATION
-- ============================================
-- TODO: Register event to handle when player uses ATM
-- RegisterNetEvent('ak_bankcard:client:CardControl', function()
--     -- TODO: Implement logic:
--     -- 1. Check if player has bank_card item
--     -- 2. If yes, start ATM animation
--     -- 3. Show progressbar
--     -- 4. After completion, request PIN from server
--     -- 5. If no card, show error notification
-- end)


-- ============================================
-- STEP 3: PIN SCREEN LOGIC
-- ============================================
-- TODO: Register event to open PIN input screen
-- RegisterNetEvent('ak_bankcard:client:OpenPin', function(pinCode)
--     -- TODO: Implement:
--     -- 1. Set NUI focus to true
--     -- 2. Send message to HTML with PIN code
--     -- 3. Open PIN entry interface
-- end)


-- ============================================
-- STEP 4: NUI CALLBACKS
-- ============================================
-- TODO: Register NUI callback for successful PIN entry
-- RegisterNUICallback('pinSuccess', function(data, cb)
--     -- TODO: Implement:
--     -- 1. Trigger server event to get bank data
--     -- 2. Notify player that PIN was correct
--     -- 3. Prepare to show bank menu
--     cb('ok')
-- end)

-- TODO: Register NUI callback for failed PIN entry
-- RegisterNUICallback('pinError', function(data, cb)
--     -- TODO: Show error notification
--     cb('ok')
-- end)


-- ============================================
-- STEP 5: BANK MENU AND OPERATIONS
-- ============================================
-- TODO: Register event to open bank menu after successful PIN
-- RegisterNetEvent('ak_bankcard:client:OpenBankMenu', function(data)
--     -- TODO: Implement:
--     -- 1. Send player data (name, IBAN, balance) to NUI
--     -- 2. Display bank interface
--     -- 3. Prepare for deposit/withdraw actions
-- end)


-- ============================================
-- STEP 6: CLOSING AND OPERATIONS
-- ============================================
-- TODO: Register NUI callback for closing UI
-- RegisterNUICallback('close', function(data, cb)
--     -- TODO: Implement:
--     -- 1. Release NUI focus
--     -- 2. Clear animations if any
--     cb('ok')
-- end)

-- TODO: Register NUI callback for bank operations
-- RegisterNUICallback('doAction', function(data, cb)
--     -- TODO: Implement:
--     -- 1. Get action type (deposit/withdraw) and amount from data
--     -- 2. Trigger server event to process transaction
--     -- 3. Handle response and update UI
--     cb('ok')
-- end)
