---@diagnostic disable: undefined-global

-- TODO: Export QBCore from qb-core resource
-- local QBCore = exports['qb-core']:GetCoreObject()

-- ============================================
-- STEP 1: AUTO-GIVE CARD ON PLAYER LOAD
-- ============================================
-- TODO: Register event for when player loads into game
-- RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
--     -- TODO: Implement logic:
--     -- 1. Get player from source
--     -- 2. Check if player already has bank_card
--     -- 3. If not, create card with:
--     --    - Player's name
--     --    - Player's IBAN/Account number
--     --    - Default PIN code (1234)
--     -- 4. Add item to player's inventory
-- end)


-- ============================================
-- STEP 2: RETRIEVE BANK DATA
-- ============================================
-- TODO: Register event to fetch player bank data
-- RegisterNetEvent('ak_bankcard:server:GetData', function()
--     local src = source
--     -- TODO: Implement:
--     -- 1. Get player object from source
--     -- 2. Extract:
--     --    - Player name (first + last name)
--     --    - Player's account/IBAN
--     --    - Player's bank balance
--     -- 3. Send data back to client
-- end)


-- ============================================
-- STEP 3: PIN CODE REQUEST
-- ============================================
-- TODO: Register event when player inserts card at ATM
-- RegisterNetEvent('ak_bankcard:server:RequestPinInfo', function()
--     local src = source
--     -- TODO: Implement:
--     -- 1. Get player object
--     -- 2. Get bank_card item from player
--     -- 3. Extract PIN from card metadata/info
--     -- 4. Send PIN code to client for verification
--     -- 5. If card not found, send error
-- end)


-- ============================================
-- STEP 4: BANK TRANSACTIONS (DEPOSIT/WITHDRAW)
-- ============================================
-- TODO: Register event for bank operations
-- RegisterNetEvent('ak_bankcard:server:ProcessTransaction', function(action, amount)
--     local src = source
--     -- TODO: Implement:
--     
--     -- 1. VALIDATION:
--     --    - Get player object
--     --    - Validate amount (must be positive number)
--     --    - Return if validation fails
--     
--     -- 2. DEPOSIT LOGIC (action == "deposit"):
--     --    - Check if player has enough cash
--     --    - Remove cash from player
--     --    - Add to bank balance
--     --    - Notify player of success/failure
--     
--     -- 3. WITHDRAW LOGIC (action == "withdraw"):
--     --    - Check if player has enough bank balance
--     --    - Remove from bank
--     --    - Add to player cash
--     --    - Notify player of success/failure
--     
--     -- 4. AFTER TRANSACTION:
--     --    - Get updated bank data
--     --    - Send updated data back to client
--     --    - Update UI with new balance
-- end)


-- ============================================
-- HELPER FUNCTION TEMPLATES
-- ============================================

-- TODO: Create helper function to get player card info
-- function GetCardInfo(src)
--     -- Get bank_card item info from player
-- end

-- TODO: Create helper function to get player account
-- function GetPlayerAccount(src)
--     -- Get player's account/IBAN info
-- end

-- TODO: Create helper function to log transactions
-- function LogTransaction(src, action, amount)
--     -- TODO: Optional - Log all transactions to database
-- end
