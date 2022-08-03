QBCore = {}
local DropCount = 0

-- SENDS DROP COUNT TO SERVER FOR CORRECT PAYMENT --
RegisterNetEvent('qbr-construction:GetDropCount', function(count)
    local source = src
    local Player = exports['qbr-core']:GetPlayer(src)

    DropCount = count
end)

-- CHECKS IF PLAYER WAS PAID TO PREVENT EXPLOITS --
exports['qbr-core']:CreateCallback('qbr-construction:CheckIfPaycheckCollected', function(source, cb)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local dropCount = tonumber(amount)
    local payment = (DropCount * Config.PayPerDrop)

    if Player.Functions.AddMoney(Config.Moneytype, payment) then -- Removes money type and amount
        DropCount = 0
        cb(true)
    else
        cb(false)
    end
end)