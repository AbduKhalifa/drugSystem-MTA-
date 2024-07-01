local adrenTimer = nil

function addSpeed(checked)
    local player = getLocalPlayer()
    local playerHave = getElementData(player, "drug.Speed")
    function stopDrug()
        setTimer(function()
            if not guiCheckBoxGetSelected(checked) then
                setGameSpeed(1)
                guiSetAlpha(speed, 0.3)
                guiCheckBoxSetSelected(checked, false)
                setElementData(player, 'activeSpeed', false)
            else
                addSpeed(checked)
            end
        end, 90000, 1)
    end

    if playerHave <= 0 then
        setGameSpeed(1)
        guiSetAlpha(speed, 0.3)
        guiCheckBoxSetSelected(checked, false)
        setElementData(player, 'activeSpeed', false)
        return
    end
    setElementData(player, "drug.Speed", playerHave - 1)
    setGameSpeed(1.7)
    stopDrug()
    guiSetAlpha(speed, 1)
end

function addAdrenaline(checked)
    local player = getLocalPlayer()
    local playerHave = getElementData(player, "drug.Adrenaline")

    function increasePlayerHealth()
        local player = getLocalPlayer()
        local health = getElementHealth(player)

        if health < 200 and not isPedDead(player) then -- التأكد من أن الصحة لا تتجاوز 100
            setElementHealth(player, health + 2)
        end
    end
    function stopDrug()
        setTimer(function()
            if not guiCheckBoxGetSelected(checked) then
                killTimer(adrenTimer)
                guiSetAlpha(adren, 0.3)
                guiCheckBoxSetSelected(checked, false)
                setElementData(player, 'activeAdrenaline', false)
            else
                addAdrenaline(checked)
            end

        end, 90000, 1)
    end

    if playerHave <= 0 then
        killTimer(adrenTimer)
        guiSetAlpha(adren, 0.3)
        guiCheckBoxSetSelected(checked, false)
        setElementData(player, 'activeAdrenaline', false)
        return
    end
    setElementData(player, "drug.Adrenaline", playerHave - 1)
    if adrenTimer then
        killTimer(adrenTimer)
    end
    adrenTimer = setTimer(increasePlayerHealth, 2000, 0)
    stopDrug()
    guiSetAlpha(adren, 1)
end

function addWeed(checked)
    local player = getLocalPlayer()
    local playerHave = getElementData(player, "drug.Weed")

    function jump()
        if not isPedInVehicle(getLocalPlayer()) then
            local moveState = getPedMoveState(getLocalPlayer())
            if moveState == "jump" then
                setGravity(0.003)
            elseif moveState ~= "jump" then
                setGravity(0.008)
            end
        end
    end
    function stopDrug()
        setTimer(function()
            if not guiCheckBoxGetSelected(checked) then
                -- stop
                removeEventHandler('onClientRender', getRootElement(), jump)
                guiSetAlpha(weed, 0.3)
                guiCheckBoxSetSelected(checked, false)
                setElementData(player, 'activeWeed', false)
            else
                addWeed(checked)
            end
        end, 90000, 1)
    end

    if playerHave <= 0 then
        -- stop
        removeEventHandler('onClientRender', getRootElement(), jump)
        guiSetAlpha(weed, 0.3)
        guiCheckBoxSetSelected(checked, false)
        setElementData(player, 'activeWeed', false)
        return
    end
    setElementData(player, "drug.Weed", playerHave - 1)
    -- run
    removeEventHandler('onClientRender', getRootElement(), jump)
    addEventHandler("onClientRender", getRootElement(), jump)
    stopDrug()
    guiSetAlpha(weed, 1)
end

function addHealth(checked)
    local player = getLocalPlayer()
    local playerHave = getElementData(player, "drug.SurgeX")

    function stopDrug()
        setTimer(function()
            if not guiCheckBoxGetSelected(checked) then
                -- stop
                triggerServerEvent("remove.surgex", player, player)
                guiSetAlpha(surgeX, 0.3)
                guiCheckBoxSetSelected(checked, false)
                setElementData(player, 'activeSurgeX', false)
            else
                addHealth(checked)
            end
        end, 90000, 1)
    end

    if playerHave <= 0 then
        -- stop
        triggerServerEvent("remove.surgex", player, player)
        guiSetAlpha(surgeX, 0.3)
        guiCheckBoxSetSelected(checked, false)
        setElementData(player, 'activeSurgeX', false)
        return
    end
    setElementData(player, "drug.SurgeX", playerHave - 1)
    -- run
    triggerServerEvent("active.surgex", player, player)
    stopDrug()
    guiSetAlpha(surgeX, 1)
end

function addViper(checked)
    local player = getLocalPlayer()
    local playerHave = getElementData(player, "drug.Viper")

    function stopDrug()
        setTimer(function()
            if not guiCheckBoxGetSelected(checked) then
                guiSetAlpha(viper, 0.3)
                guiCheckBoxSetSelected(checked, false)
                setElementData(player, 'activeViper', false)
                return false
            else
                addViper(checked)
                return true
            end
        end, 90000, 1)
    end

    if playerHave <= 0 then
        guiSetAlpha(viper, 0.3)
        guiCheckBoxSetSelected(checked, false)
        setElementData(player, 'activeViper', false)
        return
    end
    setElementData(player, "drug.Viper", playerHave - 1)
    stopDrug()
    guiSetAlpha(viper, 1)
end

function addHavoc(checked)
    local player = getLocalPlayer()
    local playerHave = getElementData(player, "drug.Havoc")

    function stopDrug()
        setTimer(function()
            if not guiCheckBoxGetSelected(checked) then
                guiSetAlpha(havoc, 0.3)
                guiCheckBoxSetSelected(checked, false)
                setElementData(player, 'activeHavoc', false)
                return false
            else
                addHavoc(checked)
                return true
            end
        end, 90000, 1)
    end

    if playerHave <= 0 then
        guiSetAlpha(havoc, 0.3)
        guiCheckBoxSetSelected(checked, false)
        setElementData(player, 'activeHavoc', false)
        return
    end
    setElementData(player, "drug.Havoc", playerHave - 1)
    stopDrug()
    guiSetAlpha(havoc, 1)
end

