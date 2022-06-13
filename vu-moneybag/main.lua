local QBCore = exports['qb-core']:GetCoreObject()



QBCore.Functions.AddItem('money_bag',
    { ['name'] = 'money_bag', ['label'] = 'Bagged Cash', ['weight'] = 1, ['type'] = 'item', ['image'] = 'moneybag.png',
        ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil,
        ['description'] = 'A bag with cash' })

QBCore.Functions.CreateUseableItem("money_bag", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        if item.info and item.info ~= "" then
            if Player.Functions.RemoveItem("money_bag", 1, item.slot) then
                Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
            end
        end
    end
end)

QBCore.Commands.Add("moneybag", "Add money to a bag", {}, true, function(source, args)
    if tonumber(args[1]) <= 0 then
        TriggerClientEvent('QBCore:Notify', source, "You must enter a valid amount of money", "error")
        return
    end

    if args[1] == nil then
        TriggerClientEvent('QBCore:Notify', source, "You need to specify an amount", "error")
        return
    end
    local sourcePlayer = QBCore.Functions.GetPlayer(source)
    local money = tonumber(args[1])
    local playerCash = sourcePlayer.Functions.GetMoney('cash')
    -- if the player has enough money, make a bag item with that amount of cash
    if playerCash >= money then
        info = { cash = money, user = sourcePlayer.PlayerData.citizenid }
        sourcePlayer.Functions.AddItem("money_bag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["money_bag"], "add")
        -- QBCore.Functions.GiveItem(bag, source)
        -- remove the money from the player
        sourcePlayer.Functions.RemoveMoney('cash', money)
        TriggerClientEvent('QBCore:Notify', source, "You have added $" .. money .. " to a money bag", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "You do not have enough money to make a money bag.", "error")
    end
end, 'user')
