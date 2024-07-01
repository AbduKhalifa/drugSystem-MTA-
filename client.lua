local screenWidth, screenHeight = guiGetScreenSize()
local windowWidth, windowHeight = 330, 350
local windowX, windowY = (screenWidth - windowWidth) / 2, (screenHeight - windowHeight) / 2
local window = nil
local checkboxes = {}
local labels = {}
local drugDescription = {{"SurgeX", "Makes health rise to the maximum", {255, 0, 0}, "drug.SurgeX", "activeSurgeX",
                          addHealth},
                         {"Speed", "Makes the player faster", {0, 255, 0}, "drug.Speed", "activeSpeed", addSpeed},
                         {"Adrenaline", "Increase blood 1 every 2 secs", {0, 188, 255}, "drug.Adrenaline",
                          "activeAdrenaline", addAdrenaline},
                         {"Weed", "It makes gravity relatively less", {255, 255, 0}, "drug.Weed", 'activeWeed', addWeed},
                         {"Viper", "It reduces the damage caused to you", {174, 9, 255}, "drug.Viper", 'activeViper',
                          addViper},
                         {"Havoc", "It strengthens your weapon's bullets", {255, 102, 0}, "drug.Havoc", 'activeHavoc',
                          addHavoc}}

function createWindow()
    window = guiCreateWindow(50, windowY, windowWidth, windowHeight, "drugs", false)
    guiSetAlpha(window, 1.0)
    guiWindowSetSizable(window, false)
    local checkboxY = 40

    for i = 1, #drugDescription do
        local playerHave = getElementData(getLocalPlayer(), drugDescription[i][4])
        if not playerHave then
            playerHave = 0
        end
        checkboxes[i] = guiCreateCheckBox(10, checkboxY, 20, 20, "", false, false, window)
        labels[i] = guiCreateLabel(30, checkboxY + 1, windowWidth - 50, 20, drugDescription[i][1] .. " ( " ..
            drugDescription[i][2] .. " ) (" .. playerHave .. ")", false, window)
        guiLabelSetColor(labels[i], drugDescription[i][3][1], drugDescription[i][3][2], drugDescription[i][3][3])

        checkboxY = checkboxY + 40
        addEventHandler("onClientGUIClick", checkboxes[i], function()
            local drugTypeCount = getElementData(getLocalPlayer(), drugDescription[i][4])
            if not drugTypeCount then
                drugTypeCount = 0
            end
            if guiCheckBoxGetSelected(checkboxes[i]) then
                if getElementData(getLocalPlayer(), drugDescription[i][5]) then
                    guiCheckBoxSetSelected(checkboxes[i], false)
                    return
                end
                if drugTypeCount > 0 then
                    setElementData(getLocalPlayer(), drugDescription[i][5], true)
                    drugDescription[i][6](checkboxes[i])
                else
                    guiCheckBoxSetSelected(checkboxes[i], false)
                end
            end
        end, false)
    end
    guiSetVisible(window, false)
end

function refreshLabels(array)
    local checkboxY = 40
    for i = 1, #drugDescription do
        local playerHave = getElementData(getLocalPlayer(), drugDescription[i][4])
        if not playerHave then
            playerHave = 0
        end

        guiSetText(labels[i], drugDescription[i][1] .. " ( " .. drugDescription[i][2] .. " ) (" .. playerHave .. ")")
        checkboxY = checkboxY + 40
    end
end

function toggleWindow()
    refreshLabels(labels)
    if window then
        local visible = not guiGetVisible(window)
        guiSetVisible(window, visible)
        showCursor(visible)
    end
end

createWindow()
bindKey(settings.fbutton, "down", toggleWindow)

