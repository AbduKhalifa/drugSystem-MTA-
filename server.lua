local dealerPed = createPed(28, 2003.012, 2322.773, 10.820, -90)
setElementFrozen(dealerPed, true)
setElementData(dealerPed, "isInvincible", true)
addEventHandler("onPedWasted", root, function()
    if getElementData(source, "isInvincible") then
        cancelEvent()
        setElementHealth(source, 100)
    end
end)

local drugsMarker = createMarker(2004.302, 2322.800, 9.820, "cylinder", 1.7, 255, 0, 0, 255)
local dBlip = createBlip(2004.302, 2322.800, 9.820, 24, 2, 255, 255, 255, 255, 0, 1200)

addEventHandler('onMarkerHit', drugsMarker, function(hitElement)
    if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
        triggerClientEvent(hitElement, "open.drugs.shop", hitElement)
    end
end)

addEvent("drugs.buy", true)
addEventHandler("drugs.buy", resourceRoot, function(player, type, amount, price)
    local cost = (tonumber(amount)) * (tonumber(price))
    local playerMoney = getPlayerMoney(player)
    if cost > playerMoney then
        outputChatBox("ليس لديك المال الكافي", player, 255, 0, 0)
        return
    end
    exports.money:playerSubMoney(player, cost)
    local oldAmount = getElementData(player, type)
    if not oldAmount then
        oldAmount = 0
    end
    setElementData(player, type, tonumber(amount) + oldAmount)
    if getElementData(player, type) > 50 then
        setElementData(player, type, 50)
    end
end)

addEvent("active.surgex", true)
addEventHandler("active.surgex", root, function(player)
    local hp = getElementHealth(player)
    setPedStat(player, 24, 1000)
    setElementHealth(hp)
end)
addEvent("remove.surgex", true)
addEventHandler("remove.surgex", root, function(player)
    local hp = getElementHealth(player)
    setPedStat(player, 24, 569)
    if hp > 100 then
        setElementHealth(100)
    end
end)

addEventHandler('onPlayerLogin', getRootElement(), function()
    triggerClientEvent(source, "show.drug.icons", source)
end)

function playerDamage_text(attacker, weapon, bodypart, loss)
    if getElementData(source, "safezone") then
        return
    end
    local HP = getElementHealth(source)
    local isHavoc = getElementData(attacker, "activeHavoc")
    local isViper = getElementData(source, "activeViper")
    local realLoss = loss
    local factLoss = loss
    local enhance = 0
    if not isHavoc and not isViper then
        return
    end
    if isHavoc then
        local values = {1.1, 1.3, 1.2, 1.4}
        local ranIndex = math.random(1, #values)
        enhance = (realLoss * values[ranIndex]) - realLoss
    end
    if isViper then
        local values = {0.4, 0.7, 0.8, 0.9, 0.6, 0.5}
        local ranIndex = math.random(1, #values)
        factLoss = realLoss * values[ranIndex]
    end

    setElementHealth(source,HP + ((realLoss - factLoss) - enhance))
end
addEventHandler("onPlayerDamage", root, playerDamage_text)
