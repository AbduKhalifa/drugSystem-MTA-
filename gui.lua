local screenWidth, screenHeight = guiGetScreenSize()
local imageSize = 36
local x = (screenWidth / 2) - ((176 + 50) / 2)
local y = screenHeight - 50

addEvent("show.drug.icons", true)
addEventHandler("show.drug.icons", root, function()
    surgeX = guiCreateStaticImage(x, y, imageSize, imageSize, "images/surge.png", false)
    guiSetAlpha(surgeX, 0.3)
    speed = guiCreateStaticImage(x + 36 + 10, y, imageSize, imageSize, "images/speed.png", false)
    guiSetAlpha(speed, 0.3)
    adren = guiCreateStaticImage(x + 72 + 20, y, imageSize, imageSize, "images/adren.png", false)
    guiSetAlpha(adren, 0.3)
    weed = guiCreateStaticImage(x + 108 + 30, y, imageSize, imageSize, "images/weed.png", false)
    guiSetAlpha(weed, 0.3)
    viper = guiCreateStaticImage(x + 142 + 40, y, imageSize, imageSize, "images/viper.png", false)
    guiSetAlpha(viper, 0.3)
    havoc = guiCreateStaticImage(x + 176 + 50, y, imageSize, imageSize, "images/havoc.png", false)
    guiSetAlpha(havoc, 0.3)
end)

local drugs = {{
    title = "SurgeX",
    price = settings.price.surgex,
    color = {255, 0, 0},
    key = "drug.SurgeX"
}, {
    title = "Speed",
    price = settings.price.speed,
    color = {0, 255, 0},
    key = "drug.Speed"
}, {
    title = "Adrenaline",
    price = settings.price.adren,
    color = {0, 188, 255},
    key = "drug.Adrenaline"
}, {
    title = "Weed",
    price = settings.price.weed,
    color = {255, 255, 0},
    key = "drug.Weed"
}, {
    title = "Viper",
    price = settings.price.viper,
    color = {174, 9, 255},
    key = "drug.Viper"
}, {
    title = "Havoc",
    price = settings.price.havoc,
    color = {255, 102, 0},
    key = "drug.Havoc"
}}
function createShop()
    function cursor()
        showCursor(true, true)
    end
    addEventHandler("onClientRender", root, cursor)
    local window = guiCreateWindow(screenWidth / 2 - 250, screenHeight / 2 - 250, 500, 500, "Drugs Shop", false)
    guiWindowSetSizable(window, false)
    guiWindowSetMovable(window, false)
    guiSetAlpha(window, 1)

    local startY = 50

    for i, drug in ipairs(drugs) do
        local titleLabel = guiCreateLabel(20, startY + (i - 1) * 50, 200, 20, drug.title, false, window)
        guiSetFont(titleLabel, "default-bold-small")
        local editField = guiCreateEdit(240, startY + (i - 1) * 50, 100, 20, 0, false, window)
        local priceLabel = guiCreateLabel(360, startY + (i - 1) * 50, 80, 20, "$" .. drug.price, false, window)
        guiLabelSetColor(priceLabel, unpack(drug.color))
        guiEditSetMaxLength(editField, 3)

        local buyButton = guiCreateButton(450, startY + (i - 1) * 50 - 5, 100, 30, "شراء", false, window)
        addEventHandler("onClientGUIClick", buyButton, function()
            local amountToBuy = tonumber(guiGetText(editField))
            if amountToBuy and amountToBuy > 0 then
                triggerServerEvent("drugs.buy", resourceRoot, getLocalPlayer(), drug.key, guiGetText(editField),
                    drug.price)
                guiSetText(editField, 0)
            else
                outputChatBox("الرجاء إدخال كمية صالحة للشراء", 255, 0, 0)
            end
        end, false)

        addEventHandler("onClientGUIChanged", editField, function()

            local currentHave = tonumber(getElementData(getLocalPlayer(), drug.key))
            if not currentHave then
                currentHave = 0
            end
            local maxAvaliable = 50 - currentHave
            if not maxAvaliable then
                maxAvaliable = 0
            else
                maxAvaliable = tonumber(maxAvaliable)
            end
            local text = guiGetText(editField)
            local newText = text:gsub("[^%d]", "")
            if newText ~= text then
                guiSetText(editField, newText)
            end
            if tonumber(newText) > maxAvaliable then
                guiSetText(editField, maxAvaliable)
            end
        end, false)
    end

    local warnm =
        "تأكد بأن كل لاعب لا يمكن ان يحمل اكثر من 50 من وحده المخدرات"
    local warnLabel = guiCreateLabel(0, 380, 500, 30, warnm, false, window)
    guiLabelSetHorizontalAlign(warnLabel, "center")
    guiLabelSetVerticalAlign(warnLabel, "label")

    local closeButton = guiCreateButton(20, 440, 460, 40, "إغلاق النافذه", false, window)
    addEventHandler("onClientGUIClick", closeButton, function()
        removeEventHandler("onClientRender", root, cursor)
        showCursor(false)
        destroyElement(window)
    end, false)
end

addEvent("open.drugs.shop", true)
addEventHandler("open.drugs.shop", root, createShop)

